import 'package:flutter/material.dart';
import 'package:get_that_bread/models/menu.dart';

class MenuBar extends StatelessWidget {
  String title;
  MenuBar(Menu menu) {
    title = menu.title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              title,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
