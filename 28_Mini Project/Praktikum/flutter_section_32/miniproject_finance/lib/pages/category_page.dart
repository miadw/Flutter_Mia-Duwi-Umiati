import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniproject_finance/models/database.dart';
import 'package:miniproject_finance/provider/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isExpense = true;
  int type = 2;
  final AppDb database = AppDb();
  TextEditingController categoryNameController = TextEditingController();

  Future insert(String name, int type) async {
    DateTime now = DateTime.now();
    final row = await database.into(database.categories).insertReturning(
        CategoriesCompanion.insert(
            name: name, type: type, createdAt: now, updatedAt: now));
  }

  Future update(int categoryId, String newName) async {
    return await database.updateCategoryRepo(categoryId, newName);
  }

  void openDialog(Category? category) {
    if (category != null) {
      categoryNameController.text = category.name;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      (isExpense)
                          ? "Tambah kategori pengeluaran"
                          : "Tambah kategori pemasukan",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: (isExpense) ? Colors.red : Colors.green),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: categoryNameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Nama kategori"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (category == null) {
                            insert(
                                categoryNameController.text, isExpense ? 2 : 1);
                          } else {
                            update(category.id, categoryNameController.text);
                            setState(() {});
                          }

                          Navigator.of(context, rootNavigator: true)
                              .pop('Dialog');
                          setState(() {});
                          categoryNameController.clear();
                        },
                        child: const Text("Simpan"))
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Kategori'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openDialog(null);
          },
          backgroundColor: Colors.grey[900],
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                const SizedBox(height: 18),
                const Text(
                  'Jenis Transaksi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Pemasukan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: isExpense,
                      onChanged: (bool value) {
                        setState(() {
                          isExpense = value;
                          type = value ? 2 : 1;
                        });
                      },
                      inactiveTrackColor: Colors.green[200],
                      inactiveThumbColor: Colors.green,
                      activeColor: Colors.red,
                    ),
                    const Text(
                      'Pengeluaran',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                FutureBuilder<List<Category>>(
                    future: categoryProvider.getAllCategory(type),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.hasData) {
                          if (snapshot.data!.length > 0) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color:
                                                Color.fromARGB(255, 69, 69, 69),
                                            width: 1),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: ListTile(
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () {
                                                  database.deleteCategoryRepo(
                                                      snapshot.data![index].id);
                                                },
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.edit),
                                                onPressed: () {
                                                  openDialog(
                                                      snapshot.data![index]);
                                                },
                                              )
                                            ],
                                          ),
                                          leading: Container(
                                              padding: const EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: (isExpense)
                                                  ? Icon(Icons.arrow_circle_up,
                                                      color:
                                                          Colors.redAccent[400])
                                                  : Icon(
                                                      Icons.arrow_circle_down,
                                                      color: Colors
                                                          .greenAccent[400],
                                                    )),
                                          title:
                                              Text(snapshot.data![index].name)),
                                    ),
                                  );
                                });
                          } else {
                            return const Center(
                              child: Text(
                                  "Belum ada kategori. Ayo buat kategori~"),
                            );
                          }
                        } else {
                          return const Center(
                            child:
                                Text("Belum ada kategori. Ayo buat kategori~"),
                          );
                        }
                      }
                    }),
              ],
            )));
  }
}
