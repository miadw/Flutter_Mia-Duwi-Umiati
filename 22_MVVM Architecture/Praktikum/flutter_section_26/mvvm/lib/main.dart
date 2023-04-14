import 'package:flutter/material.dart';
import 'package:mvvm/view/view.dart';
import 'package:mvvm/viewmodel/viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemViewModel(),
      child: MaterialApp(
        title: 'Kontak',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: LoginPage(),
      ),
    );
  }
}
