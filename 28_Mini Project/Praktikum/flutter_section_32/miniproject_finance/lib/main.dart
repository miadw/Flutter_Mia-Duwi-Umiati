import 'package:flutter/material.dart';
import 'package:miniproject_finance/pages/splashcreen.dart';
import 'package:provider/provider.dart';
import 'package:miniproject_finance/pages/main_page.dart';
import 'package:miniproject_finance/provider/category_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        color: Color(0xFF212121),
      )),
    );
  }
}
