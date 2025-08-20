import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informasi Aplikasi')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Aplikasi KampusKu adalah aplikasi yang digunakan untuk pendaftaran mahasiswa.\n'
          'User nantinya bisa menambahkan, update, dan hapus data mahasiswa.\n',
        ),
      ),
    );
  }
}
