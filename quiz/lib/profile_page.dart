// ignore_for_file: use_null_aware_elements
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'gallery_widget.dart';
import 'edit_profile_page.dart';
import 'upload_experience_page.dart';

// =====================================================================
// PROFILE PAGE
// =====================================================================
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Rifs Ramadhani';
  String role = 'Mahasiswa Teknik Informatika';
  String imagePath = 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&h=150&q=80';
  String tentang = 'Belajar Flutter!';
  String pendidikan = 'Teknik Informatika - Semester 8';
  String lokasi = 'Bandung, Jawa Barat';
  String kontak = 'rifs@student.ac.id';
  List<String> skills = ['Flutter', 'Dart', 'Java', 'Python', 'Git'];

  List<ExperienceData> experiences = [];

  Future<void> _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          initialName: name,
          initialRole: role,
          initialImagePath: imagePath,
          initialTentang: tentang,
          initialPendidikan: pendidikan,
          initialLokasi: lokasi,
          initialKontak: kontak,
          initialSkills: skills,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        name = result['name'];
        role = result['role'];
        imagePath = result['imagePath'];
        tentang = result['tentang'];
        pendidikan = result['pendidikan'];
        lokasi = result['lokasi'];
        kontak = result['kontak'];
        skills = result['skills'];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profil berhasil diperbarui'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _navigateToAddExperience() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UploadExperiencePage(),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        experiences.add(result as ExperienceData);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pengalaman berhasil ditambahkan'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _editExperience(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadExperiencePage(
          initialExperience: experiences[index],
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        experiences[index] = result as ExperienceData;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pengalaman berhasil diperbarui'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget _buildProfileImage() {
    if (imagePath.isEmpty) {
      return const CircleAvatar(
        radius: 52,
        backgroundColor: Colors.blue,
        child: Icon(Icons.person, size: 52, color: Colors.white),
      );
    }
    if (kIsWeb || imagePath.startsWith('http://') || imagePath.startsWith('https://') || imagePath.startsWith('blob:')) {
      return CircleAvatar(
        radius: 52,
        backgroundColor: Colors.blue,
        backgroundImage: NetworkImage(imagePath),
      );
    } else {
      final file = File(imagePath);
      if (file.existsSync()) {
        return CircleAvatar(
          radius: 52,
          backgroundColor: Colors.blue,
          backgroundImage: FileImage(file),
        );
      } else {
        return const CircleAvatar(
          radius: 52,
          backgroundColor: Colors.blue,
          child: Icon(Icons.person, size: 52, color: Colors.white),
        );
      }
    }
  }

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
            ListTile(
              leading: const Icon(Icons.file_upload_outlined, color: Colors.green),
              title: const Text(
                'Upload Pengalaman',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                _navigateToAddExperience();
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
                      child: _buildProfileImage(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      role,
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
              _SectionCard(
                icon: Icons.info_outline,
                title: 'Tentang Saya',
                content: tentang,
              ),
              _SectionCard(
                icon: Icons.school_outlined,
                title: 'Pendidikan',
                content: pendidikan,
              ),
              _SectionCard(
                icon: Icons.location_on_outlined,
                title: 'Lokasi',
                content: lokasi,
              ),
              _SectionCard(
                icon: Icons.email_outlined,
                title: 'Kontak',
                content: kontak,
              ),

              // === SECTION 5: SKILLS ===
              _SectionCard(
                icon: Icons.star_outline,
                title: 'Skills',
                contentWidget: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skills.map((skill) {
                      final hasIcon = skill.toLowerCase() == 'flutter';
                      return Chip(
                        label: Text(skill),
                        avatar: hasIcon
                            ? const Icon(Icons.flash_on, size: 16, color: Colors.blue)
                            : null,
                        backgroundColor: Colors.white,
                      );
                    }).toList(),
                  ),
                ),
              ),

              // === SECTION 6: PENGALAMAN (BONUS) ===
              _SectionCard(
                icon: Icons.collections_bookmark_outlined,
                title: 'Pengalaman',
                headerBadge: experiences.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${experiences.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null,
                contentWidget: experiences.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Belum ada pengalaman yang ditambahkan.',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: experiences.length,
                          separatorBuilder: (context, index) => const Divider(height: 24),
                          itemBuilder: (context, index) {
                            final exp = experiences[index];
                            return InkWell(
                              onTap: () => _editExperience(index),
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: exp.imagePath.isEmpty
                                          ? const Icon(Icons.image, color: Colors.grey)
                                          : (kIsWeb || exp.imagePath.startsWith('http') || exp.imagePath.startsWith('blob:'))
                                              ? Image.network(exp.imagePath, fit: BoxFit.cover)
                                              : Image.file(File(exp.imagePath), fit: BoxFit.cover),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  exp.title,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                                                onPressed: () {
                                                  setState(() {
                                                    experiences.removeAt(index);
                                                  });
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Pengalaman dihapus'),
                                                      behavior: SnackBarBehavior.floating,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            exp.description,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700,
                                              height: 1.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToEditProfile,
        icon: const Icon(Icons.edit),
        label: const Text('Edit Profil'),
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
  final Widget? headerBadge;

  const _SectionCard({
    required this.icon,
    required this.title,
    this.content,
    this.contentWidget,
    this.headerBadge,
  });

  @override
  Widget build(BuildContext context) {
    final badge = headerBadge;
    final childWidget = contentWidget;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (badge != null) badge,
                    ],
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
                  if (childWidget != null) childWidget,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
