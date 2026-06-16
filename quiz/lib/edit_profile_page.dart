import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final String initialName;
  final String initialRole;
  final String initialImagePath;
  final String initialTentang;
  final String initialPendidikan;
  final String initialLokasi;
  final String initialKontak;
  final List<String> initialSkills;

  const EditProfilePage({
    super.key,
    required this.initialName,
    required this.initialRole,
    required this.initialImagePath,
    required this.initialTentang,
    required this.initialPendidikan,
    required this.initialLokasi,
    required this.initialKontak,
    required this.initialSkills,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController roleController;
  late TextEditingController tentangController;
  late TextEditingController pendidikanController;
  late TextEditingController lokasiController;
  late TextEditingController kontakController;
  late TextEditingController skillsController;
  String imagePath = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName);
    roleController = TextEditingController(text: widget.initialRole);
    tentangController = TextEditingController(text: widget.initialTentang);
    pendidikanController = TextEditingController(text: widget.initialPendidikan);
    lokasiController = TextEditingController(text: widget.initialLokasi);
    kontakController = TextEditingController(text: widget.initialKontak);
    skillsController = TextEditingController(text: widget.initialSkills.join(', '));
    imagePath = widget.initialImagePath;
  }

  @override
  void dispose() {
    nameController.dispose();
    roleController.dispose();
    tentangController.dispose();
    pendidikanController.dispose();
    lokasiController.dispose();
    kontakController.dispose();
    skillsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() {
          imagePath = pickedFile.path;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memilih gambar: $e')),
      );
    }
  }

  Widget _buildProfileImage() {
    if (imagePath.isEmpty) {
      return const CircleAvatar(
        radius: 60,
        backgroundColor: Colors.indigo,
        child: Icon(Icons.person, size: 60, color: Colors.white),
      );
    }

    if (kIsWeb || imagePath.startsWith('http://') || imagePath.startsWith('https://') || imagePath.startsWith('blob:')) {
      return CircleAvatar(
        radius: 60,
        backgroundImage: NetworkImage(imagePath),
      );
    } else {
      return CircleAvatar(
        radius: 60,
        backgroundImage: FileImage(File(imagePath)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text(
              'Simpan',
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // FOTO PROFIL SECTION
                Center(
                  child: Column(
                    children: [
                      Stack(
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
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.indigo,
                              radius: 18,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                                onPressed: _pickImage,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _pickImage,
                        child: const Text(
                          'Ganti Foto dari Galeri',
                          style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // INFORMASI PROFIL SECTION
                const Text(
                  'Informasi Profil',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 16),

                // NAMA LENGKAP
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap *',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // BIO / TENTANG
                TextFormField(
                  controller: tentangController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Bio / Tentang',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 40.0),
                      child: Icon(Icons.info_outline),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // PENDIDIKAN
                TextFormField(
                  controller: pendidikanController,
                  decoration: const InputDecoration(
                    labelText: 'Pendidikan',
                    prefixIcon: Icon(Icons.school_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // LOKASI
                TextFormField(
                  controller: lokasiController,
                  decoration: const InputDecoration(
                    labelText: 'Lokasi',
                    prefixIcon: Icon(Icons.location_on_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // KONTAK
                TextFormField(
                  controller: kontakController,
                  decoration: const InputDecoration(
                    labelText: 'Kontak',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // SKILLS (Koma terpisah)
                TextFormField(
                  controller: skillsController,
                  decoration: const InputDecoration(
                    labelText: 'Skills (pisahkan dengan koma)',
                    prefixIcon: Icon(Icons.star_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // SIMPAN TOMBOL
                ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.save_outlined),
                      SizedBox(width: 8),
                      Text(
                        'Simpan Perubahan',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final skillsList = skillsController.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      Navigator.pop(context, {
        'name': nameController.text,
        'role': roleController.text,
        'imagePath': imagePath,
        'tentang': tentangController.text,
        'pendidikan': pendidikanController.text,
        'lokasi': lokasiController.text,
        'kontak': kontakController.text,
        'skills': skillsList,
      });
    }
  }
}
