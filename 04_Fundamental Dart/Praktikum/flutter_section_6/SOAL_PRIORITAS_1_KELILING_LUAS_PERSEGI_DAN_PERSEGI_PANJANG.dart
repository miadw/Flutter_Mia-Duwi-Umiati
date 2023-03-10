import 'dart:io';
void main() {
  // menghitung keliling dan luas persegi
  double sisiPersegi = 8;
  double kelilingPersegi = 4 * sisiPersegi;
  double luasPersegi = sisiPersegi * sisiPersegi;
  
  print("Persegi dengan sisi $sisiPersegi memiliki keliling $kelilingPersegi dan luas $luasPersegi");
  
  // menghitung keliling dan luas persegi panjang
  double panjang = 13;
  double lebar = 6;
  double kelilingPersegiPanjang = 2 * (panjang + lebar);
  double luasPersegiPanjang = panjang * lebar;
  
  print("Persegi panjang dengan panjang $panjang dan lebar $lebar memiliki keliling $kelilingPersegiPanjang dan luas $luasPersegiPanjang");
}
