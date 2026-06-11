import 'package:flutter_test/flutter_test.dart';
import 'package:pertemuan_6/main.dart';

void main() {
  testWidgets('App title smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the title 'Catatan Mahasiswa' is found in the widget tree.
    expect(find.text('Catatan Mahasiswa'), findsOneWidget);
  });
}
