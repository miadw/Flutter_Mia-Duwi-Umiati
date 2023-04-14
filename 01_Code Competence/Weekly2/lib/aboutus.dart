import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  AboutUsPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _services = [
    {
      'title': 'Program Flutter',
      'description':
          'Flutter adalah framework open-source yang dikembangkan oleh Google untuk membangun aplikasi mobile, web, dan desktop dengan satu basis kode.',
      'icon': Icons.flutter_dash_outlined,
    },
    {
      'title': 'Program ReactJS',
      'description':
          'ReactJS adalah library JavaScript open-source yang digunakan untuk membangun antarmuka pengguna pada aplikasi web.',
      'icon': Icons.desktop_mac_outlined,
    },
    {
      'title': 'Program Golang',
      'description':
          'Golang (atau disebut juga Go) adalah bahasa pemrograman open-source yang dikembangkan oleh Google dan digunakan untuk membangun aplikasi yang skalabel dan efisien.',
      'icon': Icons.all_out,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'About Us',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: _services
                    .map(
                      (service) => Card(
                        child: ListTile(
                          leading: Icon(service['icon'] as IconData),
                          title: Text(service['title'] as String),
                          subtitle: Text(service['description'] as String),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}