import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery Page',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/gallery': (context) => GalleryPage(),
        '/new': (context) => const NewPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery Page'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GalleryPage(),
                  ),
                );
              },
              child: const Text('Prioritas 1'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/gallery');
              },
              child: const Text('Prioritas 2'),
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryPage extends StatelessWidget {
  final List<String> images = [
    'assets/images 1.jpeg',
    'assets/images 2.jpeg',
    'assets/images 3.jpeg',
    'assets/images 4.jpeg',
    'assets/images 5.jpeg',
    'assets/images 6.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery Page'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          images.length,
          (index) => GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return ImageBottomSheet(imageUrl: images[index]);
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(images[index]),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageBottomSheet extends StatelessWidget {
  final String imageUrl;

  const ImageBottomSheet({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Konfirmasi'),
              content: const Text('Apakah Anda ingin pergi ke halaman baru?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Tidak'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/new', arguments: imageUrl);
                  },
                  child: const Text('Ya'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        height: 600,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Page'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Image.asset(imageUrl),
      ),
    );
  }
}
