import 'dart:io';
void main() {
  List<String> data = ["Ikhya", "Ulum", "Reza", "Rehan", "Ulum", "Onel", "Reza"];
  Set<String> uniqueData = data.toSet();  //mengubah list data menjadi sebuah set
  print(uniqueData);
}
