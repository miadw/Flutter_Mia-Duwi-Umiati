import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber});
}

class ContactProvider with ChangeNotifier {
  final _contacts = <Contact>[];

  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void editContact(int index, Contact contact) {
    _contacts[index] = contact;
    notifyListeners();
  }

  void removeContact(int index) {
    _contacts.removeAt(index);
    notifyListeners();
  }
}
