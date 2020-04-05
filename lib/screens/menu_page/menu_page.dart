import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
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
