import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';

class MahasiswaDetailScreen extends StatelessWidget {
  final Mahasiswa mhs;
  const MahasiswaDetailScreen({super.key, required this.mhs});

  Widget _row(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Text(': '),
          Expanded(child: Text(value ?? '-')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Mahasiswa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      child: Text(mhs.nama.isNotEmpty ? mhs.nama[0] : '?'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mhs.nama,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(mhs.nim),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32),
                _row('Program Studi', mhs.prodi),
                _row('Alamat', mhs.alamat),
                _row('Angkatan', mhs.angkatan?.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
