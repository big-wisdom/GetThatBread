import 'package:flutter/material.dart';
import 'package:get_that_bread/models/menu.dart';
import 'package:get_that_bread/routes/menu_route/menu_route.dart';

class MenuBar extends StatelessWidget {
  Menu menu;
  MenuBar(Menu menu) {
    this.menu = menu;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuRoute(menu),
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
                  menu.title,
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
