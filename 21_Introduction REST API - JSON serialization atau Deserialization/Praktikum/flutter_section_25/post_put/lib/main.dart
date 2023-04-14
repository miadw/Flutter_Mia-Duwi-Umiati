import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class Contact {
  int? id;
  String name;
  String phone;

  Contact({this.id, required this.name, required this.phone});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soal Prioritas (1)',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Soal Prioritas (1)'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('POST'),
                onPressed: () {
                  sendPostRequest();
                },
              ),
              ElevatedButton(
                child: Text('PUT'),
                onPressed: () {
                  sendPutRequest();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendPostRequest() async {
    try {
      final response = await Dio().post(
        'https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/contacts',
        data: {
          'name': 'Mia Duwi Umiati',
          'email': 'miaduwi@gmail.com',
        },
      );

      final responseData = jsonDecode(response.toString());
      print('Kode status respon: ${response.statusCode}');
      print('Data respon: $responseData');

      // Mengambil data contact dengan id 2 dari URL
      final contactResponse = await Dio().get(
        'https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/contacts/2',
      );
      final contactJson = jsonDecode(contactResponse.toString());

      // Mengubah data JSON ke dalam objek Contact
      final contact = Contact.fromJson(contactJson);

      // Mencetak data objek Contact
      print('ID: ${contact.id}');
      print('Nama: ${contact.name}');
      print('Nomor telepon: ${contact.phone}');
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> sendPutRequest() async {
    try {
      final response = await Dio().put(
        'https://jsonplaceholder.typicode.com/posts/1',
        data: {
          'id': 1,
          'title': 'foo',
          'body': 'bar',
          'userId': 1,
        },
      );

      final responseData = jsonDecode(response.toString());
      print('Kode status respon: ${response.statusCode}');
      print('Data respon: $responseData');
    } catch (error) {
      print('Error: $error');
    }
  }
}
