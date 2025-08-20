import 'package:flutter/material.dart';
import 'mahasiswa_form_screen.dart';
import 'mahasiswa_list_screen.dart';
import 'info_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Utama'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[800],
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/student.png', width: 240, height: 240),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _menuButton(
                    context,
                    Icons.list_alt,
                    'Lihat Data Mahasiswa',
                    const MahasiswaListScreen(),
                  ),
                  const SizedBox(height: 16),
                  _menuButton(
                    context,
                    Icons.person_add,
                    'Input Data Mahasiswa',
                    const MahasiswaFormScreen(),
                  ),
                  const SizedBox(height: 16),
                  _menuButton(
                    context,
                    Icons.info_outline,
                    'Informasi Aplikasi',
                    const InfoScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(
    BuildContext context,
    IconData icon,
    String title,
    Widget page,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.yellow[800],
          foregroundColor: Colors.white,
        ),
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
        icon: Icon(icon, size: 28),
        label: Text(title, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
