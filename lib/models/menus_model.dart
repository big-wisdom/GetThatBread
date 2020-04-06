import 'package:flutter/material.dart';
import 'package:get_that_bread/database/database_helper.dart';
import 'menu.dart';

class MenusModel extends ChangeNotifier {
  final db = DatabaseHelper.instance;
  List<Menu> menus = [];

  MenusModel() {
    readFromDatabase();
  }

  void readFromDatabase() {
    debugPrint("Reading menus from Database");
    Future<List<Map<String, dynamic>>> fromDb = db.queryAllRows();
    fromDb.then((value) => {
          value.forEach(
            (x) => {
              menus.add(
                Menu(
                  title: x[DatabaseHelper.columnTitle],
                  id: x[DatabaseHelper.columnId].toString(),
                ),
              ),
            },
          ),
          notifyListeners(),
        });
  }

  void addMenu(Menu menu) {
    menus.add(menu);
    db.insert(
      {
        DatabaseHelper.columnTitle: menu.title,
        DatabaseHelper.columnId: menu.id,
      },
    );
    notifyListeners();
  }

  void removeMenu(Menu menu) {
    menus.remove(menu);
    debugPrint("Menu Id: " + menu.id);
    db.delete(menu.id);
    notifyListeners();
  }
}
