import 'package:flutter/material.dart';
import 'package:miniproject_finance/models/database.dart';

class CategoryProvider extends ChangeNotifier {
  final AppDb _database = AppDb();

  Future<List<Category>> getAllCategory(int type) async {
    return await _database.getAllCategoryRepo(type);
  }
}
