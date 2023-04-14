import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galeri',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/gallery': (context) => GalleryPage(galleryBloc: GalleryBloc()),
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
        title: const Text('BLoC'),
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
                    builder: (context) =>
                        GalleryPage(galleryBloc: GalleryBloc()),
                  ),
                );
              },
              child: const Text('Galeri 1'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/gallery');
              },
              child: const Text('Galeri 2'),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class GalleryEvent {}

class GalleryLoadEvent extends GalleryEvent {}

abstract class GalleryState {}

class GalleryInitial extends GalleryState {}

class GalleryLoadedState extends GalleryState {
  final List<String> images;
  GalleryLoadedState({required this.images});
}

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final List<String> images = [
    'assets/images 1.jpeg',
    'assets/images 2.jpeg',
    'assets/images 3.jpeg',
    'assets/images 4.jpeg',
    'assets/images 5.jpeg',
    'assets/images 6.jpeg',
  ];

  GalleryBloc() : super(GalleryInitial());

  List<String> getImages() {
    return images;
  }

  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async* {
    // implementasi event ke state
  }
}

class GalleryPage extends StatelessWidget {
  final GalleryBloc galleryBloc;

  const GalleryPage({required this.galleryBloc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Galeri'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          galleryBloc.getImages().length,
          (index) => GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return ImageBottomSheet(
                      imageUrl: galleryBloc.getImages()[index]);
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(galleryBloc.getImages()[index]),
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
