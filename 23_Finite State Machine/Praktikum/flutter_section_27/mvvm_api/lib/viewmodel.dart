import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service.dart';

class FoodList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FoodViewModel>(
      builder: (context, foodViewModel, child) {
        return ListView.builder(
          itemCount: foodViewModel.foods.length,
          itemBuilder: (context, index) {
            final food = foodViewModel.foods[index];
            return ListTile(
              title: Text(food.name),
            );
          },
        );
      },
    );
  }
}
