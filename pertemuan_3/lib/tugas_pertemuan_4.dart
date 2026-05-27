import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

// ==========================================
// MODEL DATA
// ==========================================
class Catatan {
  final String id;
  final String judul;
  final String isi;
  final String kategori;
  final String emailPengirim;
  final DateTime dibuatPada;

  Catatan({
    required this.id,
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.emailPengirim,
    required this.dibuatPada,
  });
}

// ==========================================
// MAIN APPLICATION
// ==========================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/tambah':
            final arg = settings.arguments;
            return MaterialPageRoute(
              builder: (_) => TambahCatatanPage(
                catatanUntukDiubah: arg is Catatan ? arg : null,
              ),
            );
          case '/detail':
            final catatan = settings.arguments as Catatan;
            return MaterialPageRoute(
              builder: (_) => DetailCatatanPage(catatan: catatan),
            );
        }
        return null;
      },
    );
  }
}

// ==========================================
// 1. HOME PAGE (STATEFUL)
// ==========================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // STATE: Daftar Catatan
  final List<Catatan> _catatan = [
    Catatan(
      id: '1',
      judul: 'Belajar Flutter',
      isi: 'Mempelajari Stateful Widget, Form, dan Navigation hari ini di lab.',
      kategori: 'Kuliah',
      emailPengirim: 'belajar.flutter@unpas.ac.id',
      dibuatPada: DateTime.now(),
    ),
  ];

  // STATE: Kategori Terpilih untuk Filter
  String _kategoriTerpilih = 'Semua';

  // Helper warna background kategori
  Color _getCategoryColorBg(String kategori) {
    switch (kategori) {
      case 'Kuliah':
        return Colors.blue.shade50;
      case 'Tugas':
        return Colors.amber.shade50;
      case 'Pribadi':
        return Colors.green.shade50;
      case 'Lainnya':
      default:
        return Colors.purple.shade50;
    }
  }

  // Helper warna teks kategori
  Color _getCategoryColorText(String kategori) {
    switch (kategori) {
      case 'Kuliah':
        return Colors.blue.shade900;
      case 'Tugas':
        return Colors.amber.shade900;
      case 'Pribadi':
        return Colors.green.shade900;
      case 'Lainnya':
      default:
        return Colors.purple.shade900;
    }
  }

  // Fungsi Navigasi & Menangkap Data Balik dari TambahCatatanPage
  Future<void> _bukaTambahCatatan() async {
    final hasil = await Navigator.pushNamed(context, '/tambah');

    if (hasil is Catatan) {
      setState(() {
        _catatan.add(hasil);
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Catatan "${hasil.judul}" berhasil ditambahkan!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Fungsi Navigasi & Menangkap Data Edit/Update dari DetailCatatanPage
  Future<void> _bukaDetailCatatan(Catatan c) async {
    final hasilEdit = await Navigator.pushNamed(context, '/detail', arguments: c);

    if (hasilEdit is Catatan) {
      setState(() {
        final index = _catatan.indexWhere((item) => item.id == hasilEdit.id);
        if (index != -1) {
          _catatan[index] = hasilEdit;
        }
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Catatan "${hasilEdit.judul}" berhasil diperbarui!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Fungsi untuk Menghapus Catatan
  void _hapusCatatan(String id, String judul) {
    setState(() {
      _catatan.removeWhere((item) => item.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Catatan "$judul" telah dihapus'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Widget Filter Chips Horizontal
  Widget _buildFilterChips() {
    final opsi = ['Semua', 'Kuliah', 'Tugas', 'Pribadi', 'Lainnya'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: opsi.map((kat) {
          final isSelected = _kategoriTerpilih == kat;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: FilterChip(
              label: Text(kat),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _kategoriTerpilih = kat;
                });
              },
              selectedColor: Theme.of(context).colorScheme.primaryContainer,
              checkmarkColor: Theme.of(context).colorScheme.onPrimaryContainer,
              labelStyle: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter catatan berdasarkan kategori terpilih
    final filteredCatatan = _kategoriTerpilih == 'Semua'
        ? _catatan
        : _catatan.where((c) => c.kategori == _kategoriTerpilih).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Mahasiswa', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          // Filter Chips di atas list
          _buildFilterChips(),
          Expanded(
            child: filteredCatatan.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.note_alt_outlined, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada catatan.',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _kategoriTerpilih == 'Semua'
                        ? 'Tap tombol + di bawah untuk menambah'
                        : 'Tidak ada catatan di kategori ini',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              itemCount: filteredCatatan.length,
              itemBuilder: (context, i) {
                final c = filteredCatatan[i];
                final String tanggalFormatted = DateFormat('dd MMM yyyy, HH:mm').format(c.dibuatPada);

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(c.judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getCategoryColorBg(c.kategori),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: _getCategoryColorText(c.kategori).withOpacity(0.2),
                                ),
                              ),
                              child: Text(
                                c.kategori,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _getCategoryColorText(c.kategori),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Row(
                                children: [
                                  const Icon(Icons.email_outlined, size: 12, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      c.emailPengirim,
                                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              tanggalFormatted,
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      onPressed: () => _hapusCatatan(c.id, c.judul),
                    ),
                    onTap: () => _bukaDetailCatatan(c),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bukaTambahCatatan,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ==========================================
// 2. TAMBAH/UBAH CATATAN PAGE (FORM + VALIDATION)
// ==========================================
class TambahCatatanPage extends StatefulWidget {
  final Catatan? catatanUntukDiubah;
  const TambahCatatanPage({super.key, this.catatanUntukDiubah});

  @override
  State<TambahCatatanPage> createState() => _TambahCatatanPageState();
}

class _TambahCatatanPageState extends State<TambahCatatanPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _judulCtrl;
  late final TextEditingController _isiCtrl;
  late final TextEditingController _emailCtrl;

  String _kategori = 'Kuliah';
  final _kategoriOpsi = const ['Kuliah', 'Tugas', 'Pribadi', 'Lainnya'];

  @override
  void initState() {
    super.initState();
    final c = widget.catatanUntukDiubah;
    _judulCtrl = TextEditingController(text: c?.judul ?? '');
    _isiCtrl = TextEditingController(text: c?.isi ?? '');
    _emailCtrl = TextEditingController(text: c?.emailPengirim ?? '');
    if (c != null) {
      _kategori = c.kategori;
    }
  }

  @override
  void dispose() {
    _judulCtrl.dispose();
    _isiCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final c = widget.catatanUntukDiubah;
    final catatanBaru = Catatan(
      id: c?.id ?? DateTime.now().millisecondsSinceEpoch.toString(), // ID tetap jika edit, baru jika tambah
      judul: _judulCtrl.text.trim(),
      isi: _isiCtrl.text.trim(),
      kategori: _kategori,
      emailPengirim: _emailCtrl.text.trim(),
      dibuatPada: c?.dibuatPada ?? DateTime.now(),
    );

    // Kembalikan objek Catatan ke halaman sebelumnya
    Navigator.pop(context, catatanBaru);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.catatanUntukDiubah != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Ubah Catatan' : 'Tambah Catatan', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _judulCtrl,
              decoration: const InputDecoration(
                labelText: 'Judul',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Judul wajib diisi';
                if (v.trim().length < 3) return 'Minimal 3 karakter';
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _kategori,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              items: _kategoriOpsi
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: (v) => setState(() => _kategori = v!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Pengirim',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Email pengirim wajib diisi';
                }
                // Validasi Regex format email
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(v.trim())) {
                  return 'Format email tidak valid (contoh: user@mail.com)';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _isiCtrl,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Isi',
                prefixIcon: Icon(Icons.notes),
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Isi wajib diisi' : null,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _simpan,
              icon: Icon(isEditing ? Icons.save_alt : Icons.save),
              label: Text(isEditing ? 'Simpan Perubahan' : 'Simpan Catatan'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. DETAIL CATATAN PAGE (STATEFUL)
// ==========================================
class DetailCatatanPage extends StatefulWidget {
  final Catatan catatan;
  const DetailCatatanPage({super.key, required this.catatan});

  @override
  State<DetailCatatanPage> createState() => _DetailCatatanPageState();
}

class _DetailCatatanPageState extends State<DetailCatatanPage> {
  late Catatan _catatan;
  bool _isUpdated = false;

  @override
  void initState() {
    super.initState();
    _catatan = widget.catatan;
  }

  // Mengubah catatan & update state halaman detail
  Future<void> _editCatatan() async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TambahCatatanPage(catatanUntukDiubah: _catatan),
      ),
    );

    if (hasil is Catatan) {
      setState(() {
        _catatan = hasil;
        _isUpdated = true;
      });
    }
  }

  Color _getCategoryColorBg(String kategori) {
    switch (kategori) {
      case 'Kuliah':
        return Colors.blue.shade50;
      case 'Tugas':
        return Colors.amber.shade50;
      case 'Pribadi':
        return Colors.green.shade50;
      case 'Lainnya':
      default:
        return Colors.purple.shade50;
    }
  }

  Color _getCategoryColorText(String kategori) {
    switch (kategori) {
      case 'Kuliah':
        return Colors.blue.shade900;
      case 'Tugas':
        return Colors.amber.shade900;
      case 'Pribadi':
        return Colors.green.shade900;
      case 'Lainnya':
      default:
        return Colors.purple.shade900;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String tanggalFormatted = DateFormat('dd MMMM yyyy, HH:mm').format(_catatan.dibuatPada);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pop(context, _isUpdated ? _catatan : null);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Catatan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, _isUpdated ? _catatan : null),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Ubah Catatan',
              onPressed: _editCatatan,
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _catatan.judul,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getCategoryColorBg(_catatan.kategori),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _getCategoryColorText(_catatan.kategori).withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      _catatan.kategori,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: _getCategoryColorText(_catatan.kategori),
                      ),
                    ),
                  ),
                  Text(
                    tanggalFormatted,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.indigo.shade100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.email_outlined, size: 18, color: Colors.indigo),
                    const SizedBox(width: 8),
                    Text(
                      'Email: ${_catatan.emailPengirim}',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.indigo.shade900),
                    ),
                  ],
                ),
              ),
              const Divider(height: 32, thickness: 1.2),
              Text(
                _catatan.isi,
                style: const TextStyle(fontSize: 16, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}