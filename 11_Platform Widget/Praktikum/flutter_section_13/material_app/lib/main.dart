import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primaryColor: const Color(0xff6200EE),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6200EE),
                centerTitle: true,
        title: const Text('My Flutter App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
        body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 0,
            color: Colors.grey[300],
          );
        },
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          final items = [
            'Learn Flutter',
            'Learn ReactJs',
            'Learn VueJs',
            'Learn Tailwind CSS',
            'Learn UI/UX',
            'Learn Figma',
            'Learn Digital Marketing',
          ];
          return ListTile(
            title: Text(items[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xff03DAC5),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  const Color(0xff6200EE),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Information',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
