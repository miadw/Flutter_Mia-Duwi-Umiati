import 'dart:io';
void main() {
  double hitungLuasLingkaran(double jariJari) {
  double luas = 3.14 * jariJari * jariJari;
  return luas;
}
  double jariJari = 7.0;
  double luasLingkaran = hitungLuasLingkaran(jariJari);
  print("Luas lingkaran dengan jari-jari $jariJari adalah $luasLingkaran");
}