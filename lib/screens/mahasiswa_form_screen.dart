import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/mahasiswa.dart';

class MahasiswaFormScreen extends StatefulWidget {
  final Mahasiswa? existing;
  const MahasiswaFormScreen({super.key, this.existing});

  @override
  State<MahasiswaFormScreen> createState() => _MahasiswaFormScreenState();
}

class _MahasiswaFormScreenState extends State<MahasiswaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nimC = TextEditingController();
  final _namaC = TextEditingController();
  final _prodiC = TextEditingController();
  final _alamatC = TextEditingController();
  final _angkatanC = TextEditingController();
  final _emailC = TextEditingController();
  final _noTeleponC = TextEditingController();
  final _tanggalLahirC = TextEditingController();

  final _db = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _nimC.text = e.nim;
      _namaC.text = e.nama;
      _prodiC.text = e.prodi;
      _alamatC.text = e.alamat ?? '';
      _angkatanC.text = e.angkatan?.toString() ?? '';
      _emailC.text = e.email ?? '';
      _noTeleponC.text = e.noTelepon ?? '';
      _tanggalLahirC.text = e.tanggalLahir ?? '';
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final angkatan = int.tryParse(_angkatanC.text.trim());
    final m = Mahasiswa(
      id: widget.existing?.id,
      nim: _nimC.text.trim(),
      nama: _namaC.text.trim(),
      prodi: _prodiC.text.trim(),
      alamat: _alamatC.text.trim().isEmpty ? null : _alamatC.text.trim(),
      angkatan: angkatan,
      email: _emailC.text.trim().isEmpty ? null : _emailC.text.trim(),
      noTelepon: _noTeleponC.text.trim().isEmpty
          ? null
          : _noTeleponC.text.trim(),
      tanggalLahir: _tanggalLahirC.text.trim().isEmpty
          ? null
          : _tanggalLahirC.text.trim(),
    );

    if (widget.existing == null) {
      await _db.insertMahasiswa(m);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil ditambahkan')),
      );
    } else {
      await _db.updateMahasiswa(m);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data berhasil diperbarui')));
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Update Data' : 'Input Data')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nimC,
                decoration: const InputDecoration(labelText: 'NIM'),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'NIM wajib diisi' : null,
              ),
              TextFormField(
                controller: _namaC,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: _prodiC,
                decoration: const InputDecoration(labelText: 'Program Studi'),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Prodi wajib diisi' : null,
              ),
              TextFormField(
                controller: _alamatC,
                decoration: const InputDecoration(
                  labelText: 'Alamat (opsional)',
                ),
                maxLines: 2,
              ),
              TextFormField(
                controller: _angkatanC,
                decoration: const InputDecoration(
                  labelText: 'Angkatan (opsional)',
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _emailC,
                decoration: const InputDecoration(
                  labelText: 'Email (opsional)',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: _noTeleponC,
                decoration: const InputDecoration(
                  labelText: 'No. Telepon (opsional)',
                ),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: _tanggalLahirC,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir (opsional)',
                  hintText: 'YYYY-MM-DD',
                ),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _save,
                  child: Text(isEdit ? 'Simpan Perubahan' : 'Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
