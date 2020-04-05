import 'package:flutter/material.dart';
import 'package:get_that_bread/database/database_helper.dart';
import 'package:get_that_bread/models/menu.dart';
import 'package:get_that_bread/models/menus_model.dart';
import 'package:get_that_bread/screens/menus_page/widgets/menu_bar.dart';
import 'package:provider/provider.dart';

class MenusPage extends StatelessWidget {
  final db = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    final menusList = Provider.of<MenusModel>(context);
    List<Dismissible> menuBars = [];
    for (Menu menu in menusList.menus) {
      menuBars.add(
        Dismissible(
          key: Key(menu.title),
          onDismissed: (direction) {
            menusList.removeMenu(menu);
            menuBars.remove(this);
          },
          child: MenuBar(menu),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Menus"),
      ),
      body: Container(
        child: ListView(children: menuBars),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => addMenu(context, menusList)),
    );
  }

  void addMenu(context, MenusModel menusList) async {
    String title = await _createAlertDialog(context);
    if (title != null) menusList.addMenu(Menu(title: title));
  }

  Future<String> _createAlertDialog(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('New Menu'),
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
