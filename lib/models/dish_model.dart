import 'package:flutter/material.dart';
import 'package:get_that_bread/database/database_helper.dart';
import 'dish.dart';
import 'ingredient.dart';

class DishModel extends ChangeNotifier {
  final db = DatabaseHelper.instance;
  Dish dish;
  List<Ingredient> ingredients = [];

  DishModel(Dish dish) {
    this.dish = dish;
    _readFromDatabase();
  }

  _readFromDatabase() {
    debugPrint("Reading ${dish.title} from the database");
    Future<List<Map<String, dynamic>>> fromDb = db.queryAllRows(dish.title);
    fromDb.then((value) {
      value.forEach(
        (x) {
          ingredients.add(Ingredient(
            title: x['title'],
            id: x['id'],
          ));
        },
      );
      notifyListeners();
    });
  }

  void addIngredient(Ingredient ingredient) {
    debugPrint("Adding ingredient: ${ingredient.title}");
    ingredients.add(ingredient);
    db.newIngredient(this.dish, ingredient);
    notifyListeners();
  }

  removeIngredient(Ingredient ingredient) {
    debugPrint("Dismissing: " + ingredient.title);
    // remove from the dish table
    db.delete(this.dish.title, ingredient.id);
    // remove from the ingredients table
    db.delete("ingredients", ingredient.id);
    // remove from this local list
    ingredients.remove(ingredient);
    notifyListeners();
  }
}
