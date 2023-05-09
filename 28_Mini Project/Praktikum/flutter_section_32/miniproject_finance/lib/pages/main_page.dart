import 'package:flutter/material.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:miniproject_finance/pages/about_page.dart';
import 'package:miniproject_finance/pages/home_page.dart';
import 'package:miniproject_finance/pages/transaction_page.dart';
import 'category_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late DateTime selectedDate;
  late List<Widget> _children;
  late int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    updateView(0, DateTime.now());
    super.initState();
  }

  void updateView(int index, DateTime? date) {
    setState(() {
      if (date != null) {
        selectedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
      }

      currentIndex = index;
      _children = [
        HomePage(
          selectedDate: selectedDate,
        ),
        const CategoryPage(),
        const AboutPage(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: (currentIndex == 0)
            ? CalendarAppBar(
                accent: Colors.grey[900],
                backButton: false,
                locale: 'id',
                onDateChanged: (value) {
                  setState(() {
                    selectedDate = value;
                    updateView(0, selectedDate);
                  });
                },
                firstDate: DateTime.now().subtract(const Duration(days: 140)),
                lastDate: DateTime.now(),
              )
            : PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, right: 0),
                    child: Text(
                      '',
                      style: GoogleFonts.poppins(
                        fontSize: 2,
                      ),
                    ),
                  ),
                ),
              ),
        floatingActionButton: Visibility(
          visible: (currentIndex == 0) ? true : false,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => const TransactionPage(
                    transactionWithCategory: null,
                  ),
                ),
              )
                  .then((value) {
                setState(() {});
              });
            },
            backgroundColor: Colors.grey[900],
            child: const Icon(Icons.add),
          ),
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _children[currentIndex],
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            updateView(index, null);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: 'Tambah Kategori',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_rounded),
              label: 'Tentang Aplikasi',
            ),
          ],
          selectedItemColor: Colors.grey[900],
          unselectedItemColor: Colors.grey[400],
        ));
  }
}
