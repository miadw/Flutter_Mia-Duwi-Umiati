import 'dart:io';
void main() {
  int size = 10;

  print("  | " + List.generate(size, (index) => "${index+1}".padLeft(2)).join(" "));
  print("--+" + List.generate(size, (index) => "--").join("-"));

  for (int i = 1; i <= size; i++) {
    String row = "$i | ";
    for (int j = 1; j <= size; j++) {
      int product = i * j;
      row += "${product}".padLeft(2) + " ";
    }
    print(row);
  }
}
