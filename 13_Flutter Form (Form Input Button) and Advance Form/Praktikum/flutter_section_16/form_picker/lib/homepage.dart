import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  final _contacts = <Map<String, dynamic>>[];
  DateTime _selectedDate = DateTime.now();
  Color _selectedColor = Colors.blue;
  int indexuser = -1;
  late File? _file = null;
  TextEditingController _fileController = TextEditingController();
  String filetext = '';

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final name = nameController.text;
        final nomor = phoneController.text;
        if (indexuser == -1) {
          _contacts.add({
            'nama': name,
            'nomor': nomor,
            'tanggal': _selectedDate,
            'color': _selectedColor, // tambahkan warna
            'file': _file?.path, // tambahkan path file
          });
        } else {
          _contacts[indexuser]['nama'] = name;
          _contacts[indexuser]['nomor'] = nomor;
          _contacts[indexuser]['tanggal'] = _selectedDate;
          _contacts[indexuser]['color'] = _selectedColor; // tambahkan warna
          _contacts[indexuser]['file'] = _file?.path; // tambahkan path file
          indexuser = -1;
        }
        nameController.clear();
        phoneController.clear();
        _file = null; // reset file picker setelah submit
        _fileController.clear(); // reset text controller setelah submit
      });
    }
  }

  void editItem(int index) {
    setState(() {
      nameController.text = _contacts[index]['nama']!;
      phoneController.text = _contacts[index]['nomor']!;
      indexuser = index;
    });
  }

  void deleteItem(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _selectColor(index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor:
                  indexuser != -1 ? _contacts[indexuser]['color'] : Colors.blue,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                if (indexuser != -1) {
                  setState(() {
                    _contacts[indexuser]['color'] = _selectedColor;
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      PlatformFile file = result.files.first;
      print(file.path);
    } else {
    // User canceled the picker
    }
  } 

  @override
  Widget build(BuildContext context) {
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
                    fontSize: 25.0,
                  ),
                ),
                const SizedBox(height: 15.0),
                const Text(
                  'A dialog is a type modal window that appears in front of app content to provide cricital information, or prompt for a decision to be made',
                  style: TextStyle(
                    fontSize: 16.0,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date"),
                    TextButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('select date'),
                    )
                  ],
                ),
                Text(DateFormat('dd-MM-yyyy').format(_selectedDate)),
                SizedBox(height: 40),
                Text(
                  'Color:',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: _selectedColor,
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(height: 40),
                Center(
                    child: ElevatedButton(
                  onPressed: () => _selectColor(indexuser),
                  child: const Text('Pick Color'),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: _selectedColor),
                )),
                const SizedBox(height: 40),
                Text(
                  'Pick Files:',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
                Center(
                    child: ElevatedButton(
                  onPressed: () {
                    _pickFile();
                  },
                  child: const Text('Pick and Open Files'),
                )),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6750A4),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: submitForm,
                    child: const Text('Submit'),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'List Contact',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 25.0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 8.0),
                  color: Color(0xFFFBFE),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _contacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = _contacts[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _contacts[index]['color'],
                          foregroundColor: Colors.black,
                        ),
                        title: Text(item['nama']!),
                        subtitle: Text(
                            '${DateFormat.yMd().format(item['tanggal'])} - ${item['nomor']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                                onPressed: () => editItem(index),
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () => deleteItem(index),
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
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