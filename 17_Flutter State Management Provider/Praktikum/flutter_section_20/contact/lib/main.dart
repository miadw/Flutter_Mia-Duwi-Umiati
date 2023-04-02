import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contactprovider.dart';
import 'list_contact.dart';
import 'form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContactProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const ContactsPage(),
          '/contacts': (context) => const ListContactPage(
                name: '',
                phoneNumber: '',
              ),
        },
      ),
    );
  }
}
