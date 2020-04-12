import 'package:flutter/material.dart';
import 'package:get_that_bread/models/dish.dart';
import 'package:get_that_bread/models/dish_model.dart';
import 'package:get_that_bread/models/ingredient.dart';
import 'package:get_that_bread/routes/dish_route/widgets/ingredient_bar.dart';
import 'package:provider/provider.dart';

class DishRoute extends StatelessWidget {
  Dish dish;
  DishRoute(Dish dish) {
    this.dish = dish;
  }

  @override
  Widget build(BuildContext context) {
    final ingredientsList = Provider.of<DishModel>(context);
    List<Dismissible> ingredientBars = [];
    for (Ingredient ingredient in ingredientsList.ingredients) {
      ingredientBars.add(
        Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            ingredientsList.removeIngredient(ingredient);
            ingredientBars.remove(this);
          },
          child: IngredientBar(ingredient),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(dish.title),
      ),
      body: Container(
        child: ListView(
          children: ingredientBars,
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => _addIngredient(context, ingredientsList)),
    );
  }

  void _addIngredient(context, DishModel ingredientsList) async {
    String title = await _createAlertDialog(context);
    if (title != null)
      ingredientsList.addIngredient(Ingredient(title: title, id: UniqueKey().toString()));
  }

  Future<String> _createAlertDialog(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('New Ingredient'),
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
