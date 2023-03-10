void main() {
  List<int> numbers = [10, 40, 50];

  for (int number in numbers) {
    int factorial = 1;
    for (int i = 1; i <= number; i++) {
      factorial *= i;
    }
    print("Faktorial dari $number adalah $factorial");
  }
}
