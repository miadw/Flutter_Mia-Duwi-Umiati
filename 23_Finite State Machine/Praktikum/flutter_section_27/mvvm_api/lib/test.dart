import 'package:mvvm_api/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';
import 'model.dart';
import 'service.dart';

class FoodViewModel {
  late http.Client _client;
  List<Food> foods = [];

  set client(http.Client value) {
    _client = value;
  }

  Future<void> fetchFoods() async {
    try {
      final response = await _client.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> foodsJson = json.decode(response.body);
        foods = foodsJson.map((json) => Food.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      throw Exception('Gagal untuk memuat data $e');
    }
  }
}

void main() {
  group('Food API', () {
    late FoodViewModel foodViewModel;

    setUp(() {
      foodViewModel = FoodViewModel();
      // Set client yang digunakan dengan MockClient
      foodViewModel.client = MockClient((request) async {
        if (request.url.toString() == apiUrl) {
          return http.Response(
            json.encode([
              {'id': 1, 'name': 'Bakso'},
              {'id': 2, 'name': 'Nasi Goreng'},
              {'id': 3, 'name': 'Teh Puci'},
            ]),
            200,
          );
        } else {
          return http.Response('Tidak ditemukan', 404);
        }
      });
    });

    test('fetchFoods mengembalikan daftar makanan', () async {
      await foodViewModel.fetchFoods();
      expect(foodViewModel.foods.length, 3);
      expect(foodViewModel.foods[0].id, 1);
      expect(foodViewModel.foods[0].name, 'Bakso');
      expect(foodViewModel.foods[1].id, 2);
      expect(foodViewModel.foods[1].name, 'Nasi Goreng');
      expect(foodViewModel.foods[2].id, 3);
      expect(foodViewModel.foods[2].name, 'Teh Puci');
    });

    test('fetchFoods memberikan pengecualian di kesalahan', () async {
      foodViewModel.client = MockClient((request) async {
        return http.Response('Tidak ditemukan', 404);
      });

      expect(foodViewModel.fetchFoods(), throwsException);
    });
  });
}
