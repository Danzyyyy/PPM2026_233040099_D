import 'package:flutter/material.dart';

// =====================================================================
// WIDGET GALLERY
// =====================================================================
class GalleryHome extends StatelessWidget {
  const GalleryHome({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      ('Display', Icons.image, Colors.blue),
      ('Input', Icons.edit, Colors.green),
      ('Button', Icons.smart_button, Colors.orange),
      ('Feedback', Icons.notifications, Colors.purple),
      ('Layout', Icons.dashboard, Colors.teal),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Gallery'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final (name, icon, color) = categories[i];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(icon, color: color),
              ),
              title: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryPage(name: name),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String name;
  const CategoryPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final body = switch (name) {
      'Display' => const _DisplayDemo(),
      'Input' => const _InputDemo(),
      'Button' => const _ButtonDemo(),
      'Feedback' => const _FeedbackDemo(),
      'Layout' => const _LayoutDemo(),
      _ => const Center(child: Text('?')),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: body,
      ),
    );
  }
}

// =====================================================================
// DEMO — DISPLAY
// =====================================================================
class _DisplayDemo extends StatelessWidget {
  const _DisplayDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Card & ListTile'),
        const Card(
          elevation: 2,
          child: ListTile(
            leading: Icon(Icons.album, color: Colors.blue),
            title: Text('Judul Item'),
            subtitle: Text('Sub-judul'),
          ),
        ),
        const SizedBox(height: 24),
        _sectionTitle('Chip'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(label: const Text('Flutter'), backgroundColor: Colors.blue.shade100),
            const Chip(label: Text('Dart')),
            const Chip(label: Text('Mobile')),
          ],
        ),
        const SizedBox(height: 24),
        _sectionTitle('Divider'),
        const Divider(thickness: 2, height: 20),
        const SizedBox(height: 16),
        _sectionTitle('CircleAvatar & Icon'),
        Row(
          children: const [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('A', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 12),
            CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.check, color: Colors.white),
            ),
            SizedBox(width: 12),
            Icon(Icons.star, color: Colors.amber, size: 40),
          ],
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

// =====================================================================
// DEMO — INPUT
// =====================================================================
class _InputDemo extends StatefulWidget {
  const _InputDemo();

  @override
  State<_InputDemo> createState() => _InputDemoState();
}

class _InputDemoState extends State<_InputDemo> {
  bool _checked = false;
  bool _switched = true;
  double _slider = 0.5;
  String? _dropdown = 'Apel';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TextField',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nama',
            hintText: 'Ketik nama Anda',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 16),
        CheckboxListTile(
          title: const Text('Checkbox'),
          subtitle: const Text('Aktifkan fitur tertentu'),
          value: _checked,
          onChanged: (v) => setState(() => _checked = v ?? false),
        ),
        SwitchListTile(
          title: const Text('Switch'),
          subtitle: const Text('Nyalakan notifikasi'),
          value: _switched,
          onChanged: (v) => setState(() => _switched = v),
        ),
        const SizedBox(height: 16),
        const Text(
          'Slider',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Slider(
          value: _slider,
          onChanged: (v) => setState(() => _slider = v),
        ),
        const SizedBox(height: 16),
        const Text(
          'Dropdown',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: _dropdown,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: ['Apel', 'Jeruk', 'Mangga']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => setState(() => _dropdown = v),
        ),
      ],
    );
  }
}

// =====================================================================
// DEMO — BUTTON
// =====================================================================
class _ButtonDemo extends StatelessWidget {
  const _ButtonDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Elevated Button'),
        ),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () {},
          child: const Text('Filled Button'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () {},
          child: const Text('Outlined Button'),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {},
          child: const Text('Text Button'),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.send),
          label: const Text('Dengan Icon'),
        ),
        const SizedBox(height: 12),
        Center(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite, color: Colors.red, size: 32),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// DEMO — FEEDBACK
// =====================================================================
class _FeedbackDemo extends StatelessWidget {
  const _FeedbackDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Halo dari SnackBar!'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: const Text('Tampilkan SnackBar'),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Konfirmasi'),
                content: const Text('Yakin ingin lanjut?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ya'),
                  ),
                ],
              ),
            );
          },
          child: const Text('Tampilkan Dialog'),
        ),
        const SizedBox(height: 24),
        const Text(
          'Progress Indicator:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        const LinearProgressIndicator(value: 0.6),
        const SizedBox(height: 24),
        const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}

// =====================================================================
// DEMO — LAYOUT
// =====================================================================
class _LayoutDemo extends StatelessWidget {
  const _LayoutDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Stack — widget bertumpuk',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Container(width: double.infinity, color: Colors.blue.shade100),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 12,
                  right: 12,
                  child: Icon(Icons.star, size: 40, color: Colors.amber),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Wrap — auto-pindah baris saat penuh',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            8,
            (i) => Chip(
              label: Text('Item ${i + 1}'),
              backgroundColor: Colors.teal.shade50,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'GridView (count: 3)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              6,
              (i) => Card(
                color: Colors.purple.shade50,
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
