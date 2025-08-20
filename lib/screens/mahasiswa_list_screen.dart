import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/mahasiswa.dart';
import 'mahasiswa_form_screen.dart';
import 'mahasiswa_detail_screen.dart';

class MahasiswaListScreen extends StatefulWidget {
  const MahasiswaListScreen({super.key});

  @override
  State<MahasiswaListScreen> createState() => _MahasiswaListScreenState();
}

class _MahasiswaListScreenState extends State<MahasiswaListScreen> {
  final _db = DatabaseHelper.instance;
  String _query = '';

  Future<List<Mahasiswa>> _load() => _db.getAllMahasiswa(search: _query);

  void _showOptions(Mahasiswa m) async {
    final action = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.visibility_outlined),
              title: const Text('Lihat Data'),
              onTap: () => Navigator.pop(ctx, 'view'),
            ),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Update Data'),
              onTap: () => Navigator.pop(ctx, 'edit'),
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Hapus Data'),
              onTap: () => Navigator.pop(ctx, 'delete'),
            ),
          ],
        ),
      ),
    );

    if (!mounted) return;
    switch (action) {
      case 'view':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MahasiswaDetailScreen(mhs: m)),
        ).then((_) => setState(() {}));
        break;
      case 'edit':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MahasiswaFormScreen(existing: m)),
        ).then((_) => setState(() {}));
        break;
      case 'delete':
        _confirmDelete(m);
        break;
    }
  }

  void _confirmDelete(Mahasiswa m) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Data'),
        content: Text('Yakin hapus ${m.nama}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await _db.deleteMahasiswa(m.id!);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data dihapus')));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data Mahasiswa'),
        actions: [
          IconButton(
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Cari nim/nama/prodi...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Mahasiswa>>(
        future: _load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data ?? [];
          if (data.isEmpty) {
            return const Center(child: Text('Belum ada data'));
          }
          return ListView.separated(
            itemCount: data.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (context, index) {
              final m = data[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(m.nama.isNotEmpty ? m.nama[0] : '?'),
                ),
                title: Text(m.nama),
                subtitle: Text(
                  '${m.nim} • ${m.prodi}${m.angkatan != null ? ' • ${m.angkatan}' : ''}',
                ),
                onTap: () => _showOptions(m),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MahasiswaFormScreen()),
        ).then((_) => setState(() {})),
        label: const Text('Input Data'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
