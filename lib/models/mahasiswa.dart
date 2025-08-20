class Mahasiswa {
  int? id;
  String nim;
  String nama;
  String prodi;
  String? alamat;
  int? angkatan;
  String? email;
  String? noTelepon;
  String? tanggalLahir;

  Mahasiswa({
    this.id,
    required this.nim,
    required this.nama,
    required this.prodi,
    this.alamat,
    this.angkatan,
    this.email,
    this.noTelepon,
    this.tanggalLahir,
  });

  factory Mahasiswa.fromMap(Map<String, dynamic> map) => Mahasiswa(
    id: map['id'] as int?,
    nim: map['nim'] as String,
    nama: map['nama'] as String,
    prodi: map['prodi'] as String,
    alamat: map['alamat'] as String?,
    angkatan: map['angkatan'] as int?,
    email: map['email'] as String?,
    noTelepon: map['no_telepon'] as String?,
    tanggalLahir: map['tanggal_lahir'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'nim': nim,
    'nama': nama,
    'prodi': prodi,
    'alamat': alamat,
    'angkatan': angkatan,
    'email': email,
    'no_telepon': noTelepon,
    'tanggal_lahir': tanggalLahir,
  };
}
