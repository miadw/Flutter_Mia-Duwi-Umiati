import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service.dart';
import 'viewmodel.dart';

class FoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FoodViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Soal Prioritas (1)'),
        ),
        body: Center(
          child: Consumer<FoodViewModel>(
            builder: (context, foodViewModel, child) {
              if (foodViewModel.foods.isEmpty) {
                foodViewModel.fetchFoods();
                return CircularProgressIndicator();
              } else {
                return FoodList();
              }
            },
          ),
        ),
      ),
    );
  }
}
