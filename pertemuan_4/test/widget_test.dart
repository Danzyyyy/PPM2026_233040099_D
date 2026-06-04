import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pertemuan_3/latihan.dart';

void main() {
  testWidgets('Mini App Catatan Mahasiswa Full Flow Test', (WidgetTester tester) async {
    // 1. Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify default dummy note exists on HomePage
    expect(find.text('Belajar Flutter'), findsOneWidget);
    expect(find.text('belajar.flutter@unpas.ac.id'), findsOneWidget);
    expect(find.text('Kuliah'), findsNWidgets(2));

    // 2. Tap the '+' FAB to open TambahCatatanPage
    final fab = find.byIcon(Icons.add);
    expect(fab, findsOneWidget);
    await tester.tap(fab);
    await tester.pumpAndSettle();

    // Verify we are on the Tambah Catatan screen
    expect(find.text('Tambah Catatan'), findsOneWidget);

    // 3. Test Form Validation (press Simpan with empty fields)
    final saveButton = find.text('Simpan Catatan');
    expect(saveButton, findsOneWidget);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    // Verify validation errors are shown
    expect(find.text('Judul wajib diisi'), findsOneWidget);
    expect(find.text('Email pengirim wajib diisi'), findsOneWidget);
    expect(find.text('Isi wajib diisi'), findsOneWidget);

    // 4. Fill form with valid details
    final judulField = find.widgetWithText(TextFormField, 'Judul');
    final emailField = find.widgetWithText(TextFormField, 'Email Pengirim');
    final isiField = find.widgetWithText(TextFormField, 'Isi');

    await tester.enterText(judulField, 'Tugas PPM');

    // Change category via Dropdown (Let's select 'Tugas')
    final dropdown = find.widgetWithText(DropdownButtonFormField<String>, 'Kategori');
    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    // Tap 'Tugas' option from dropdown items
    final tugasOption = find.text('Tugas').last;
    await tester.tap(tugasOption);
    await tester.pumpAndSettle();

    // Fill email with invalid format to test regex validation
    await tester.enterText(emailField, 'invalid-email');
    await tester.enterText(isiField, 'Mengerjakan Modul Pertemuan 3 Flutter.');
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    // Verify invalid email format validation is triggered
    expect(find.text('Format email tidak valid (contoh: user@mail.com)'), findsOneWidget);

    // Fill correct email format and submit again
    await tester.enterText(emailField, 'ppm@unpas.ac.id');
    await tester.tap(saveButton);
    await tester.pumpAndSettle(); // Back to HomePage

    // Verify we are back on HomePage and new note is listed
    expect(find.text('Catatan Mahasiswa'), findsOneWidget);
    expect(find.text('Tugas PPM'), findsOneWidget);
    expect(find.text('ppm@unpas.ac.id'), findsOneWidget);

    // 5. Test Category Filtering
    // Tap 'Tugas' filter chip
    final tugasFilterChip = find.widgetWithText(FilterChip, 'Tugas');
    await tester.tap(tugasFilterChip);
    await tester.pumpAndSettle();

    // Should display 'Tugas PPM' but NOT 'Belajar Flutter'
    expect(find.text('Tugas PPM'), findsOneWidget);
    expect(find.text('Belajar Flutter'), findsNothing);

    // Tap 'Semua' filter chip to show all again
    final semuaFilterChip = find.widgetWithText(FilterChip, 'Semua');
    await tester.tap(semuaFilterChip);
    await tester.pumpAndSettle();

    expect(find.text('Tugas PPM'), findsOneWidget);
    expect(find.text('Belajar Flutter'), findsOneWidget);

    // 6. Test Delete Note
    final listTile = find.ancestor(
      of: find.text('Tugas PPM'),
      matching: find.byType(Card),
    );
    final deleteButton = find.descendant(
      of: listTile,
      matching: find.byIcon(Icons.delete_outline),
    );
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    // Verify 'Tugas PPM' is deleted
    expect(find.text('Tugas PPM'), findsNothing);
    expect(find.text('Belajar Flutter'), findsOneWidget);
  });
}
