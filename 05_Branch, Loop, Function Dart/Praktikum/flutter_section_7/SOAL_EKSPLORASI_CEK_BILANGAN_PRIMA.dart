import 'dart:io';

void main() {
  stdout.write("Masukkan sebuah bilangan: ");
  int number = int.parse(stdin.readLineSync()!);

  bool isPrime = checkPrime(number);

  if (isPrime) {
    print("$number adalah bilangan prima");
  } else {
    print("$number bukan bilangan prima");
  }
}

bool checkPrime(int number) {
  if (number <= 1) {
    return false;
  }

  for (int i = 2; i <= number / 2; i++) {
    if (number % i == 0) {
      return false;
    }
  }

  return true;
}
