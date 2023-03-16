import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Material App',
    theme: ThemeData.dark(),
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
             const ListTile(
              title: Text("Home"),
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Settings'),
                      content: const Text('This is the settings page.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: CircleAvatar(
              child: Text('L'),
            ),
            title: Text('Leanne Graham'),
            subtitle: Text('1-770-736-8031 x56442'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('E'),
            ),
            title: Text('Ervin Howell'),
            subtitle: Text('010-692-6593 x09125'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('C'),
            ),
            title: Text('Clementine Bauch'),
            subtitle: Text('1-463-123-4447'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('P'),
            ),
            title: Text('Patricia Lebsack'),
            subtitle: Text('493-170-9623 x156'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('C'),
            ),
            title: Text('Chelsey Dietrich'),
            subtitle: Text('(254)954-1289'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('M'),
            ),
            title: Text('Mrs. Dennis Schulist'),
            subtitle: Text('1-477-935-8478 x6430'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Text('K'),
            ),
            title: Text('Kurtis Weissnat'),
            subtitle: Text('210.067.6132'),
          ),
        ],
      ),
    );
  }
}
