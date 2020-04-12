import 'package:flutter/material.dart';
import 'package:get_that_bread/models/ingredient.dart';

class IngredientBar extends StatelessWidget {
  Ingredient ingredient;
  IngredientBar(Ingredient ingredient) {
    this.ingredient = ingredient;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => debugPrint("You tapped ${this.ingredient.title}"),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black),
            ),
          ),
          height: 60,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  ingredient.title,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
