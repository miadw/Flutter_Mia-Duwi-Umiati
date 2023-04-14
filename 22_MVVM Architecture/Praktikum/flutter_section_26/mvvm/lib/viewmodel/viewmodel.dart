import 'package:flutter/material.dart';
import 'package:mvvm/model/model.dart';

class ItemViewModel extends ChangeNotifier {
  List<Item> _items = [
    Item(name: "Budi Santoso", phone: 899966667777),
    Item(name: "Ani Susilo", phone: 811122223333),
  ];

  List<Item> get items => _items;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }
}
