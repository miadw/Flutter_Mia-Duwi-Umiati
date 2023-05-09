import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniproject_finance/models/database.dart';
import 'package:miniproject_finance/models/transaction_with_category.dart';
import 'package:miniproject_finance/pages/transaction_page.dart';

class HomePage extends StatefulWidget {
  final DateTime selectedDate;
  const HomePage({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<int> _futureIncomeSum;
  late Future<int> _futureExpenseSum;
  final AppDb database = AppDb();

  @override
  void initState() {
    super.initState();
    _futureIncomeSum = getIncomeSumRepo();
    _futureExpenseSum = getExpenseSumRepo();
  }

  Future<int> getIncomeSumRepo() async {
    return await database.getIncomeSumRepo(1);
  }

  Future<int> getExpenseSumRepo() async {
    return await database.getExpenseSumRepo(2);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.arrow_circle_down, color: Colors.green),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pemasukan",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 12),
                          ),
                          const SizedBox(height: 2),
                          FutureBuilder<int>(
                            future: _futureIncomeSum,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                if (snapshot.hasData) {
                                  return Text(
                                    "Rp${snapshot.data}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  );
                                } else {
                                  return const Text("Memuat data...");
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.arrow_circle_up, color: Colors.red),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pengeluaran",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 12),
                          ),
                          const SizedBox(height: 2),
                          FutureBuilder<int>(
                            future: _futureExpenseSum,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                if (snapshot.hasData) {
                                  return Text(
                                    "Rp${snapshot.data}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  );
                                } else {
                                  return const Text("Memuat data...");
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Transaksi",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          StreamBuilder<List<TransactionWithCategory>>(
              stream: database.getTransactionByDateRepo(widget.selectedDate),
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
                                    horizontal: 16, vertical: 4),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Color.fromARGB(255, 69, 69, 69),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: ListTile(
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () async {
                                            await database
                                                .deleteTransactionRepo(snapshot
                                                    .data![index]
                                                    .transaction
                                                    .id);
                                            setState(() {});
                                          },
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  TransactionPage(
                                                transactionWithCategory:
                                                    snapshot.data![index],
                                              ),
                                            ));
                                          },
                                        )
                                      ],
                                    ),
                                    title: Text(
                                        "Rp${snapshot.data![index].transaction.amount}"),
                                    subtitle: Text(
                                        "${snapshot.data![index].category.name} (${snapshot.data![index].transaction.name})"),
                                    leading: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: (snapshot
                                                  .data![index].category.type ==
                                              2)
                                          ? const Icon(Icons.arrow_circle_up,
                                              color: Colors.red)
                                          : const Icon(Icons.arrow_circle_down,
                                              color: Colors.green),
                                    ),
                                  ),
                                ));
                          });
                    } else {
                      return const Center(
                        child: Text("Hari ini masih belum ada transaksi"),
                      );
                    }
                  } else {
                    return const Center(
                      child: Text("Belum ada transaksi"),
                    );
                  }
                }
              }),
        ],
      )),
    );
  }
}
