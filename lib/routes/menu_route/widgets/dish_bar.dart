import 'package:flutter/material.dart';
import 'package:get_that_bread/models/dish.dart';

class DishBar extends StatelessWidget {
  Dish dish;
  DishBar(Dish dish) {
    this.dish = dish;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => debugPrint("Tapped: ${dish.title}"),
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
