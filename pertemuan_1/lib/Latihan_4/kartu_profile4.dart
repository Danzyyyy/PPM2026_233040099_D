import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profil & Latihan Widget'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('👋', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              const Text(
                'Halo, Wildan!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Kartu Profil dengan Integrasi Row (Latihan 3)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('NIM: 233040099', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    const Text('Prodi: Teknik Informatika', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    const Text('Semester: 6', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),

                    // Implementasi Latihan 3: Row di dalam kartu
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.code, color: Colors.blue),
                        Icon(Icons.terminal, color: Colors.blue),
                        Icon(Icons.flutter_dash, color: Colors.blue),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Tap Saya'),
              ),
            ],
          ),
        ),

        // Implementasi Latihan 4: Bottom Bar Mock-up
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.home, size: 32, color: Colors.red),
              Icon(Icons.receipt_long, size: 32, color: Colors.green),
              Icon(Icons.favorite, size: 32, color: Colors.purple),
              Icon(Icons.person, size: 32, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}