import 'package:flutter/material.dart';
import 'package:get_that_bread/models/dish.dart';
import 'package:get_that_bread/models/menu.dart';
import 'package:get_that_bread/models/menu_model.dart';
import 'package:get_that_bread/routes/menu_route/widgets/dish_bar.dart';
import 'package:provider/provider.dart';

class MenuRoute extends StatelessWidget {
  Menu menu;
  MenuRoute(Menu menu) {
    this.menu = menu;
  }

  @override
  Widget build(BuildContext context) {
    final dishesList = Provider.of<MenuModel>(context);
    List<Dismissible> menuBars = [];
    for (Dish dish in dishesList.dishes) {
      menuBars.add(
        Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            dishesList.removeDish(dish);
            menuBars.remove(this);
          },
          child: DishBar(dish),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(menu.title),
      ),
      body: Container(
        child: ListView(
          children: menuBars,
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => _addDish(context, dishesList)),
    );
  }

  void _addDish(context, MenuModel dishesList) async {
    String title = await _createAlertDialog(context);
    if (title != null)
      dishesList.addDish(Dish(title: title, id: UniqueKey().toString()));
  }

  Future<String> _createAlertDialog(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('New Dish'),
          content: TextField(
            autofocus: true,
            controller: textEditingController,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
            FlatButton(
              child: Text('Add'),
              onPressed: () {
                Navigator.of(context)
                    .pop(textEditingController.text.toString());
              },
            )
          ],
        );
      },
    );
  }
}
