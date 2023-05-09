import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'Deskripsi aplikasi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Aplikasi mobile ini merupakan sebuah aplikasi finansial pribadi yang menggunakan Flutter Provider dan SQLite (Drift) dan dapat membantu pengguna dalam mengelola keuangan pribadi, sehingga pengguna dapat memperoleh gambaran yang lebih jelas tentang pengeluaran mereka dan mengambil tindakan yang diperlukan untuk mengelola keuangan mereka menjadi lebih baik.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Fitur utama',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 15),
            Text(
              '1. Menambahkan data keuangan: Pengguna dapat menambahkan data keuangan mereka ke dalam aplikasi.\n'
              '2. Melihat data keuangan: Pengguna dapat melihat data keuangan yang telah ditambahkan ke dalam aplikasi.\n'
              '3. Mengedit data keuangan: Pengguna dapat mengedit data keuangan yang telah ditambahkan ke dalam aplikasi apabila terdapat perubahan atau kesalahan yang perlu diganti.\n'
              '4. Menghapus data keuangan: Pengguna dapat menghapus data keuangan apabila data tersebut sudah tidak diperlukan atau sudah tidak relevan lagi.\n',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
