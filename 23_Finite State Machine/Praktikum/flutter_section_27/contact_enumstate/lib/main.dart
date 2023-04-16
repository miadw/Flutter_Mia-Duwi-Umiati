import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginPageState {
  loading,
  login,
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kontak',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _rememberMe = false;
  LoginPageState _state = LoginPageState.login;

  void _saveLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      prefs.setString('username', _usernameController.text);
    } else {
      prefs.remove('username');
    }
  }

  void _login() {
    setState(() {
      _state = LoginPageState.loading;
    });
    _saveLoginInfo();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactsPage()),
    );
  }

  void _loadLoginInfo() async {
    setState(() {
      _state = LoginPageState.loading;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username != null) {
      setState(() {
        _usernameController.text = username;
        _rememberMe = true;
      });
    }
    setState(() {
      _state = LoginPageState.login;
    });
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: _state == LoginPageState.loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text('Ingat saya'),
                    ],
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Masuk'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _logout,
                    child: Text('Keluar'),
                  ),
                ],
              ),
            ),
    );
  }
}

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});
  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  final _contacts = <Map<String, String>>[];
  int indexuser = -1;

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final name = nameController.text;
        final nomor = phoneController.text;
        if (indexuser == -1) {
          _contacts.add({'nama': name, 'nomor': nomor});
        } else {
          _contacts[indexuser]['nama'] = name;
          _contacts[indexuser]['nomor'] = nomor;
          indexuser = -1;
        }
        nameController.clear();
        phoneController.clear();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontak'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('username');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Icon(Icons.app_shortcut_outlined),
                SizedBox(height: 8),
                const Text(
                  'Selamat datang,',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                FutureBuilder(
                  future: SharedPreferences.getInstance(),
                  builder: (BuildContext context,
                      AsyncSnapshot<SharedPreferences> snapshot) {
                    if (snapshot.hasData) {
                      String? username = snapshot.data!.getString('username');
                      if (username != null && username.isNotEmpty) {
                        return Text(
                          username,
                          style: TextStyle(fontSize: 16.0),
                        );
                      }
                    }
                    return const Text(
                      'pengguna!',
                      style: TextStyle(fontSize: 16.0),
                    );
                  },
                ),
                SizedBox(height: 16),
                const Divider(thickness: 2),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    fillColor: Color(0XFFE7E0EC),
                    labelText: 'Nama',
                    hintText: 'Masukkan nama',
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
                    labelText: 'Nomor HP',
                    hintText: '0812 3456 7890',
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
                    onPressed: submitForm,
                    child: const Text('Masukkan'),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Daftar kontak',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24.0,
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
                          backgroundColor: Color(0XFFEADDFF),
                          foregroundColor: Colors.black,
                          child: Text(item['nama']![0].toUpperCase()),
                        ),
                        title: Text(item['nama']!),
                        subtitle: Text('${item['nomor']!}'),
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
