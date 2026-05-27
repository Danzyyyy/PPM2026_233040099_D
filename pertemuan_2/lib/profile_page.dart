import 'package:flutter/material.dart';
import 'gallery_widget.dart';

// =====================================================================
// PROFILE PAGE
// =====================================================================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Aksi lainnya ditekan'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.indigo],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 36, color: Colors.indigo),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Menu Utama',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Beranda ditekan'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Pengaturan'),
                    content: const Text(
                      'Halaman Pengaturan sedang dalam pengembangan.',
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.widgets, color: Colors.blue),
              title: const Text(
                'Widget Gallery',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GalleryHome()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3F4F6), Color(0xFFE5E7EB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // === HEADER PROFIL ===
              Center(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&h=150&q=80',
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Ilham Anugrah',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mahasiswa Teknik Informatika',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // === BARIS STATISTIK ===
              Row(
                children: const [
                  Expanded(child: _StatBox(label: 'Post', value: '12')),
                  Expanded(child: _StatBox(label: 'Teman', value: '128')),
                  Expanded(child: _StatBox(label: 'Like', value: '1.2K')),
                ],
              ),

              const SizedBox(height: 24),

              // === SECTION CARDS ===
              const _SectionCard(
                icon: Icons.info_outline,
                title: 'Tentang Saya',
                content:
                    'Saya suka belajar hal baru, terutama yang berkaitan '
                    'dengan teknologi dan pengembangan aplikasi mobile.',
              ),
              const _SectionCard(
                icon: Icons.school,
                title: 'Pendidikan',
                content: 'Universitas XYZ — Semester 5\nIPK: 3.75',
              ),
              const _SectionCard(
                icon: Icons.favorite,
                title: 'Hobi & Minat',
                content: 'Coding • Membaca • Fotografi • Game',
              ),
              const _SectionCard(
                icon: Icons.email,
                title: 'Kontak',
                content: 'email@example.com\n+62 812-3456-7890',
              ),

              // === SECTION 5: SKILLS (TUGAS MANDIRI) ===
              const _SectionCard(
                icon: Icons.star,
                title: 'Skills',
                contentWidget: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        label: Text('Flutter'),
                        avatar: Icon(Icons.flash_on, size: 16, color: Colors.blue),
                        backgroundColor: Colors.white,
                      ),
                      Chip(
                        label: Text('Dart'),
                        backgroundColor: Colors.white,
                      ),
                      Chip(
                        label: Text('UI/UX'),
                        backgroundColor: Colors.white,
                      ),
                      Chip(
                        label: Text('Git'),
                        backgroundColor: Colors.white,
                      ),
                      Chip(
                        label: Text('Android'),
                        backgroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Edit profil belum tersedia'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1, // Profil
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
          NavigationDestination(icon: Icon(Icons.message), label: 'Pesan'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Setting'),
        ],
        onDestinationSelected: (index) {
          if (index != 1) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Tab ${index == 0 ? "Home" : index == 2 ? "Pesan" : "Setting"} ditekan',
                ),
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
      ),
    );
  }
}

// =====================================================================
// HELPER WIDGETS — PROFILE PAGE
// =====================================================================
class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white.withValues(alpha: 0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? content;
  final Widget? contentWidget;

  const _SectionCard({
    required this.icon,
    required this.title,
    this.content,
    this.contentWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.blue.shade700, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (content != null)
                    Text(
                      content!,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.grey.shade800,
                        fontSize: 14,
                      ),
                    ),
                  ?contentWidget,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
