import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _textEditingController = TextEditingController();
  String _svgImage = '';
  String _base64Image = '';

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Soal Eksplorasi'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Masukkan kata kunci',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await http.get(Uri.parse(
                    'https://avatars.dicebear.com/api/female/${_textEditingController.text}.svg'));

                if (response.statusCode == 200) {
                  final svgString = response.body;
                  final document = XmlDocument.parse(svgString);
                  final svgElement = document.rootElement;

                  final svgImage = svgElement.getAttribute('xmlns') ==
                          'http://www.w3.org/2000/svg'
                      ? svgString
                      : '';
                  final base64Image = svgElement.getAttribute('xmlns') ==
                          'http://www.w3.org/2000/svg'
                      ? ''
                      : svgString.split(',').last;

                  setState(() {
                    _svgImage = svgImage;
                    _base64Image = base64Image;
                  });
                }
              },
              child: Text('Muat gambar'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: _svgImage.isNotEmpty
                    ? SvgPicture.string(
                        _svgImage,
                        width: 300,
                        height: 300,
                      )
                    : _base64Image.isNotEmpty
                        ? Image.memory(
                            base64Decode(_base64Image),
                            width: 300,
                            height: 300,
                          )
                        : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
