import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Mata Kuliah Informatika',
      home: Scaffold(
      appBar: AppBar(
          title: Text('Daftar Mata Kuliah Informatika'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),

        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Nama : Mia Duwi Umiati'),
            ),
            ListTile(
              title: Text('NIM : 20081010063'),
            ),
            ListTile(
              leading: Icon(Icons.code),
              title: Text('Pemrograman Dasar'),
              subtitle: Text('3 SKS'),
            ),
            ListTile(
              leading: Icon(Icons.developer_board),
              title: Text('Struktur Data'),
              subtitle: Text('3 SKS'),
            ),
            ListTile(
              leading: Icon(Icons.storage),
              title: Text('Basis Data'),
              subtitle: Text('3 SKS'),
            ),
            ListTile(
              leading: Icon(Icons.mobile_friendly),
              title: Text('Pemrograman Aplikasi Mobile'),
              subtitle: Text('3 SKS'),
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text('Pemrograman Web'),
              subtitle: Text('3 SKS'),
            ),
            ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text('Pemrograman Berorientasi Object'),
              subtitle: Text('3 SKS'),
            ),
            ListTile(
              leading: Icon(Icons.numbers_rounded),
              title: Text('Matematika Diskrit'),
              subtitle: Text('3 SKS'),
            ),
          ],
        ),
      ),
    );
  }
}
