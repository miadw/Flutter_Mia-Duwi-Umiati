import 'dart:io';
void main() {
  String kata = "kasur rusak";
  String kataTanpaSpasi = kata.replaceAll(" ", ""); // menghapus spasi pada kata
  String kataDibalik = kataTanpaSpasi.split('').reversed.join(); // membalikkan urutan karakter pada kata
  
  if (kataTanpaSpasi.toLowerCase() == kataDibalik.toLowerCase()) {
    print("$kata adalah palindrom");
  } else {
    print("$kata bukan palindrom");
  }
}
