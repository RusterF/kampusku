import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import '../models/mahasiswa.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get database async => _db ??= await _initDB();

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'kampusku.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE mahasiswa (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nim TEXT NOT NULL,
        nama TEXT NOT NULL,
        prodi TEXT NOT NULL,
        alamat TEXT,
        angkatan INTEGER
      )
    ''');

    // Seed data (opsional)
    await db.insert('mahasiswa', {
      'nim': '2301001',
      'nama': 'Sinta Rahma',
      'prodi': 'Informatika',
      'alamat': 'Jl. Kenanga 12',
      'angkatan': 2023,
    });
  }

  // CRUD OPERATIONS
  Future<int> insertMahasiswa(Mahasiswa mhs) async {
    final db = await database;
    return await db.insert('mahasiswa', mhs.toMap());
  }

  Future<List<Mahasiswa>> getAllMahasiswa({String? search}) async {
    final db = await database;
    List<Map<String, dynamic>> maps;
    if (search != null && search.trim().isNotEmpty) {
      maps = await db.query(
        'mahasiswa',
        where: 'nim LIKE ? OR nama LIKE ? OR prodi LIKE ?',
        whereArgs: ['%$search%', '%$search%', '%$search%'],
        orderBy: 'id DESC',
      );
    } else {
      maps = await db.query('mahasiswa', orderBy: 'id DESC');
    }
    return maps.map((e) => Mahasiswa.fromMap(e)).toList();
  }

  Future<Mahasiswa?> getMahasiswaById(int id) async {
    final db = await database;
    final maps = await db.query('mahasiswa', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) return Mahasiswa.fromMap(maps.first);
    return null;
  }

  Future<int> updateMahasiswa(Mahasiswa mhs) async {
    final db = await database;
    return await db.update('mahasiswa', mhs.toMap(), where: 'id = ?', whereArgs: [mhs.id]);
  }

  Future<int> deleteMahasiswa(int id) async {
    final db = await database;
    return await db.delete('mahasiswa', where: 'id = ?', whereArgs: [id]);
  }
}