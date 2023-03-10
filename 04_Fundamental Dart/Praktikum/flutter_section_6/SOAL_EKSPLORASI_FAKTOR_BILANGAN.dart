import 'dart:io';

void main() {
  stdout.write("Masukkan sebuah bilangan: ");
  int bilangan = int.parse(stdin.readLineSync()!);
  List<int> faktor = []; // list kosong untuk menyimpan faktor bilangan
  
  for (int i = 1; i <= bilangan; i++) {
    if (bilangan % i == 0) {
      faktor.add(i); // menambahkan i ke dalam list faktor jika i adalah faktor bilangan
    }
  }
  
  print("Faktor dari $bilangan adalah: $faktor");
}
