import 'dart:math';

void main() {
  List<double> nilaiMahasiswa = [85, 75, 87, 92, 83];
  double total = nilaiMahasiswa.reduce((a, b) => a + b); //menjumlahkan setiap elemen
  double rerata = total / nilaiMahasiswa.length;
  int rerataPembulatan = rerata.ceil(); //membulatkan hasil rata-rata ke atas
  print('Rata-rata nilai Mahasiswa adalah $rerataPembulatan');
}
