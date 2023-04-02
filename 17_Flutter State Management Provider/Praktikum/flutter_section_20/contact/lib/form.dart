import 'package:contact/list_contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contactprovider.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});
  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  final List<Map<String, String>> _contacts = [];
  int indexuser = -1;

  void submitForm(ContactProvider provider, int indexuser) {
    if (_formKey.currentState!.validate()) {
      final name = nameController.text;
      final nomor = phoneController.text;
      if (indexuser == -1) {
        provider.addContact(Contact(name: name, phoneNumber: nomor));
      } else {
        provider.editContact(
            indexuser, Contact(name: name, phoneNumber: nomor));
        setState(() {
          this.indexuser = -1;
        });
      }
      nameController.clear();
      phoneController.clear();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListContactPage(name: name, phoneNumber: nomor),
        ),
      );
    }
  }

  void editItem(ContactProvider provider, int index) {
    nameController.text = provider.contacts[index].name;
    phoneController.text = provider.contacts[index].phoneNumber;
    setState(() {
      indexuser = index;
    });
  }

  void deleteItem(ContactProvider provider, int index) {
    provider.removeContact(index);
  }

  String? validasiname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama harus diisi';
    }
    final nameParts = value.split(' ');
    if (nameParts.length < 2) {
      return 'Nama harus terdiri dari minimal 2 kata';
    }
    for (final part in nameParts) {
      if (!RegExp(r'^[A-Z][a-z]*$').hasMatch(part)) {
        return 'Setiap kata harus dimulai dengan huruf kapital dan \n tidak boleh mengandung angka atau karakter khusus';
      }
    }
    return null;
  }

  String? validasiphone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon harus diisi';
    }
    if (!RegExp(r'^0\d{7,14}$').hasMatch(value)) {
      return 'Nomor telepon harus dimulai dengan angka 0 dan terdiri dari \n 8-15 digit angka';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider =
        Provider.of<ContactProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: const Color(0XFF6200EE),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Icon(Icons.app_shortcut_outlined),
                const Text(
                  'Create New Contact',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 15.0),
                const Text(
                  'A dialog is a type modal window that appears in front of app content to provide cricital information, or prompt for a decision to be made',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                const Divider(thickness: 2),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    fillColor: Color(0XFFE7E0EC),
                    labelText: 'Name',
                    hintText: 'Insert your name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    filled: true,
                  ),
                  validator: validasiname,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    fillColor: Color(0XFFE7E0EC),
                    labelText: 'Phone Number',
                    hintText: '+62 ....',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    filled: true,
                  ),
                  validator: validasiphone,
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6750A4),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () => submitForm(contactProvider, indexuser),
                    child: const Text('Submit'),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'List Contact',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24.0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 8.0),
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    editItem(contactProvider, index);
                                    indexuser = index;
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteItem(contactProvider, index);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
