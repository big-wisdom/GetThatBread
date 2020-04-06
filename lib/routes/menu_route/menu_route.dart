import 'package:flutter/material.dart';
import 'package:get_that_bread/models/menu.dart';

class MenuRoute extends StatelessWidget {
  Menu menu;
  MenuRoute(Menu menu) {
    this.menu = menu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menu.title),
      ),
      body: Container(
        child: Text(
            "This is a Menu page for some menu which shall be named later."),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => debugPrint("Adding Menu")),
    );
  }
}
