import 'dart:async';

void main() async {
  int n = 9;
  int faktorial = await hitungFaktorial(n);
  print('Faktorial dari $n adalah $faktorial');
}

Future<int> hitungFaktorial(int n) async {
  int faktorial = 1;
  for (int i = 2; i <= n; i++) {
    faktorial *= i;
    await Future.delayed(Duration(milliseconds: 100)); //menunda eksekusi selama 100 milidetik pada setiap iterasi perulangan
  }
  return faktorial;
}
