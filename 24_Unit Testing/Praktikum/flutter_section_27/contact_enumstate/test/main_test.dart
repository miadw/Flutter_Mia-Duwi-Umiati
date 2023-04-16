import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:contact_enumstate/main.dart';

void main() {
  testWidgets('Judul halaman harus "Login"', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Get the title widget
    final titleFinder = find.text('Login');
    expect(titleFinder, findsOneWidget);

    // Get the AppBar widget
    final appBarFinder = find.byType(AppBar);
    expect(appBarFinder, findsOneWidget);

    // Get the AppBar widget's parent Scaffold
    final scaffoldFinder =
        find.ancestor(of: appBarFinder, matching: find.byType(Scaffold));
    expect(scaffoldFinder, findsOneWidget);
  });
}
