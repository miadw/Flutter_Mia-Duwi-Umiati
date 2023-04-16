import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_testing/main.dart';

void main() {
  testWidgets('Judul halaman harus "Login"', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Cek halaman Kontak bagian judul dan body',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ContactsPage(),
      ),
    );
    expect(find.text('Kontak'), findsOneWidget);
    expect(find.text('Create New Contact'), findsOneWidget);
    expect(find.text('Daftar kontak'), findsOneWidget);
  });
}
