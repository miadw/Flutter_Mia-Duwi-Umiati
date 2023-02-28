import 'dart:io';
Future<List<int>> multiplyList(List<int> data, int multiplier) async {
  List<int> result = [];
  for (int i = 0; i < data.length; i++) {
    await Future.delayed(Duration(milliseconds: 100)); // simulasi delay
    result.add(data[i] * multiplier);
  }
  return result;
}

void main() async {
  List<int> data = [1, 2, 3, 4, 5];
  int multiplier = 2;

  List<int> result = await multiplyList(data, multiplier);

  print("Hasil perkalian dari $data x $multiplier adalah $result");
}
