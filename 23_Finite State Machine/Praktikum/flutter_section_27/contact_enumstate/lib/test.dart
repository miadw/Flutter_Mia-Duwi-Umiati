import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:contact_enumstate/main.dart';

void main() {
  group('LoginPage', () {
    SharedPreferences.setMockInitialValues({});

    testWidgets('Test login process', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      final usernameField = find.widgetWithText(TextFormField, 'Username');
      expect(usernameField, findsOneWidget);

      final passwordField = find.widgetWithText(TextFormField, 'Password');
      expect(passwordField, findsOneWidget);

      final rememberMeCheckbox = find.widgetWithText(Checkbox, 'Ingat saya');
      expect(rememberMeCheckbox, findsOneWidget);

      final masukButton = find.widgetWithText(ElevatedButton, 'Masuk');
      expect(masukButton, findsOneWidget);

      final keluarButton = find.widgetWithText(ElevatedButton, 'Keluar');
      expect(keluarButton, findsOneWidget);

      // Test login process
      await tester.enterText(usernameField.first, 'test');
      await tester.enterText(passwordField.first, 'password');
      await tester.tap(rememberMeCheckbox.first);
      await tester.tap(masukButton.first);
      await tester.pump();

      final contactsPageTitle = find.widgetWithText(AppBar, 'Kontak');
      expect(contactsPageTitle, findsOneWidget);

      // Test logout process
      await tester.tap(keluarButton.first);
      await tester.pumpAndSettle();

      final loginPageTitle = find.widgetWithText(AppBar, 'Login');
      expect(loginPageTitle, findsOneWidget);
    });
  });
}
