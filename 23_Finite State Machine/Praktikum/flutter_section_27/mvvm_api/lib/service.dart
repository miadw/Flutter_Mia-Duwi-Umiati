import 'dart:convert';
import 'package:flutter/material.dart';
import 'model.dart';
import 'package:http/http.dart' as http;

final String apiUrl =
    "https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/foods";

class FoodViewModel extends ChangeNotifier {
  List<Food> _foods = [];

  List<Food> get foods => _foods;

  Future<void> fetchFoods() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> foodsJson = json.decode(response.body);
      _foods = foodsJson.map((json) => Food.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Gagal memuat');
    }
  }
}
