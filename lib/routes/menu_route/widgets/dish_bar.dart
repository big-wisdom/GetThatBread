import 'package:flutter/material.dart';
import 'package:get_that_bread/models/dish.dart';
import 'package:get_that_bread/models/dish_model.dart';
import 'package:get_that_bread/routes/dish_route/dish_route.dart';
import 'package:provider/provider.dart';

class DishBar extends StatelessWidget {
  Dish dish;
  DishBar(Dish dish) {
    this.dish = dish;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => DishModel(dish),
                  child: DishRoute(dish),
                ),
              ),
            ),
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
                  dish.title,
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
