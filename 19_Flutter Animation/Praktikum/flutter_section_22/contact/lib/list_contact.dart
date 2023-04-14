import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contactprovider.dart';
import 'form.dart';

class ListContactPage extends StatelessWidget {
  final String name;
  final String phoneNumber;

  const ListContactPage({required this.name, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontak'),
      ),
      body: Container(
        color: const Color(0x00fffbfe),
        child: Consumer<ContactProvider>(
          builder: (context, contactProvider, _) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: contactProvider.contacts.length,
              itemBuilder: (BuildContext context, int index) {
                final item = contactProvider.contacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0XFFEADDFF),
                    foregroundColor: Colors.black,
                    child: Text(item.name[0].toUpperCase()),
                  ),
                  title: Text(item.name),
                  subtitle: Text(item.phoneNumber),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const ContactsPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = const Offset(-1.0, 0.0);
                var end = Offset.zero;
                var curve = Curves.easeOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
              transitionDuration: Duration(milliseconds: 700),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
