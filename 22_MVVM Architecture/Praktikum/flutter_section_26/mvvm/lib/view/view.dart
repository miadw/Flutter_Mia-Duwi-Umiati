import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mvvm/model/model.dart';
import 'package:mvvm/viewmodel/viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _rememberMe = false;

  void _saveLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      prefs.setString('username', _usernameController.text);
    } else {
      prefs.remove('username');
    }
  }

  void _login() {
    _saveLoginInfo();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ItemView()),
    );
  }

  void _loadLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username != null) {
      setState(() {
        _usernameController.text = username;
        _rememberMe = true;
      });
    }
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
      body: Padding(
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

class ItemView extends StatefulWidget {
  const ItemView({Key? key}) : super(key: key);

  @override
  _ItemViewState createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            const Text(
              'Selamat datang,',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 15.0),
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
            const SizedBox(height: 16.0),
            const Divider(thickness: 2),
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                fillColor: Color(0XFFE7E0EC),
                labelText: 'Nama',
                hintText: 'Masukkan nama...',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                filled: true,
              ),
              validator: validasiname,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _phoneController,
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final String name = _nameController.text;
                final int phone = int.parse(_phoneController.text);
                final Item item = Item(name: name, phone: phone);
                Provider.of<ItemViewModel>(context, listen: false)
                    .addItem(item);
                _nameController.clear();
                _phoneController.clear();
              },
              child: Text('Tambah kontak'),
            ),
            SizedBox(height: 32),
            const Text(
              'Daftar kontak',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Consumer<ItemViewModel>(
                builder: (context, itemViewModel, child) {
                  final List<Item> items = itemViewModel.items;
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final Item item = items[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0XFFEADDFF),
                          foregroundColor: Colors.black,
                          child: Text(item.name[0].toUpperCase()),
                        ),
                        title: Text(item.name),
                        subtitle: Text('+62${item.phone}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete)),
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
    );
  }
}
