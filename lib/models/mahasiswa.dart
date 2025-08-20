class Mahasiswa {
  int? id;
  String nim;
  String nama;
  String prodi;
  String? alamat;
  int? angkatan;

  Mahasiswa({
    this.id,
    required this.nim,
    required this.nama,
    required this.prodi,
    this.alamat,
    this.angkatan,
  });

  factory Mahasiswa.fromMap(Map<String, dynamic> map) => Mahasiswa(
    id: map['id'] as int?,
    nim: map['nim'] as String,
    nama: map['nama'] as String,
    prodi: map['prodi'] as String,
    alamat: map['alamat'] as String?,
    angkatan: map['angkatan'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'nim': nim,
    'nama': nama,
    'prodi': prodi,
    'alamat': alamat,
    'angkatan': angkatan,
  };
}
