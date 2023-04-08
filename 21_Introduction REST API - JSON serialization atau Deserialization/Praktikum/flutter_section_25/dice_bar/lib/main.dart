import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soal Prioritas (2)',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String imageUrl = '';

  Future<String> getImageUrl() async {
    final response = await http
        .get(Uri.parse('https://avatars.dicebear.com/api/female/example.svg'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Gagal memuat gambar');
    }
  }

  @override
  void initState() {
    super.initState();
    getImageUrl().then((value) {
      setState(() {
        imageUrl = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soal Prioritas (2)'),
      ),
      body: Center(
        child: imageUrl.isEmpty
            ? CircularProgressIndicator()
            : SvgPicture.string(
                imageUrl,
                width: 200,
                height: 200,
              ),
      ),
    );
  }
}
