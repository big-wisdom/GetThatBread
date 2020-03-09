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
      child: Row(
        children: <Widget>[Text(title)],
      ),
    );
  }
}
