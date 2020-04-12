import 'package:flutter/material.dart';
import 'package:get_that_bread/database/database_helper.dart';

import 'dish.dart';
import 'menu.dart';

class MenuModel extends ChangeNotifier {
  final db = DatabaseHelper.instance;
  Menu menu;
  List<Dish> dishes = [];

  MenuModel(Menu menu) {
    this.menu = menu;
    _readFromDatabase();
  }

  _readFromDatabase() {
    debugPrint("Reading ${menu.title} from the database");
    Future<List<Map<String, dynamic>>> fromDb = db.queryAllRows(menu.title);
    fromDb.then((value) {
      value.forEach(
        (x) {
          dishes.add(Dish(
            title: x['title'],
            id: x['id'],
          ));
        },
      );
      notifyListeners();
    });
  }

  void addDish(Dish dish) {
    debugPrint("Adding dish: ${dish.title}");
    dishes.add(dish);
    db.newDish(menu, dish);
    notifyListeners();
  }

  removeDish(Dish dish) {
    debugPrint("Dismissing: " + dish.title);
    db.delete(menu.title, dish.id);
    dishes.remove(dish);
    notifyListeners();
  }
}
