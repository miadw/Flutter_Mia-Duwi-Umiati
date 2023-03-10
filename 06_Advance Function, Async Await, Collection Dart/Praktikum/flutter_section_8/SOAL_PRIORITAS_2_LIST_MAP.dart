import 'dart:io';
void main() {
  List<List<String>> dataList = [
    ["Fiony", "Tangerang"],
    ["Della", "Bekasi"],
    ["Zahra", "Garut"]
  ];

  Map<String, String> dataMap = {};

  for (int i = 0; i < dataList.length; i++) {
    String name = dataList[i][0];
    String address = dataList[i][1];
    dataMap[name] = address;
  }

  print("$dataMap");
}
