import 'dart:io';

import 'package:get_that_bread/models/dish.dart';
import 'package:get_that_bread/models/ingredient.dart';
import 'package:get_that_bread/models/menu.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "GetThatBread.db";
  static final _databaseVersion = 1;

  static final table = 'menus';

  static final columnId = 'id';
  static final columnTitle = 'title';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    // create the menus table
    await db.execute('''
          CREATE TABLE $table (
            $columnId TEXT PRIMARY KEY,
            $columnTitle TEXT NOT NULL
          )
          ''');

    // create the ingredients data table
    await db.execute('''
          CREATE TABLE ingredients (
            $columnId TEXT PRIMARY KEY,
            $columnTitle TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // Creates a new table to store the dishes of that menu
  // and add the title of this menu to the menus table
  Future newMenu(Menu menu) async {
    // Create a table for that menus dishes
    Database db = await instance.database;
    await db.execute('''CREATE TABLE ${menu.title} (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL
      )
    ''');

    // add the title to the list of menus
    db.insert(
      table,
      {"id": menu.id, "title": menu.title},
    );
  }

  Future deleteMenu(Menu menu) async {
    Database db = await instance.database;
    // Remove from list of menus
    await db.delete("menus", where: '$columnId = ?', whereArgs: [menu.id]);
    // Delete this menu table
    await db.execute('''DROP TABLE IF EXISTS ${menu.title}''');
  }

  Future deleteDish(Menu menu, Dish dish) async {
    Database db = await instance.database;
    // Remove from list of menus
    await db.delete(menu.title, where: '$columnId = ?', whereArgs: [dish.id]);
    // Delete this dish table
    await db.execute('''DROP TABLE IF EXISTS ${dish.title}''');
  }

  Future newDish(Menu menu, Dish dish) async {
    Database db = await instance.database;
    // Add this to the respective menus table
    db.insert(
      menu.title,
      {"id": dish.id, "title": dish.title},
    );

    // create a new table for this dish
    await db.execute('''CREATE TABLE ${dish.title} (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL
      )
    ''');
  }

  Future newIngredient(Dish dish, Ingredient ingredient) async {
    Database db = await instance.database;
    // Add this to the respective dish table
    db.insert(
      dish.title,
      {"id": ingredient.id, "title": ingredient.title},
    );

    // add this ingredient to the ingredients table
    db.insert(
      "ingredients",
      {"id": ingredient.id, "title": ingredient.title},
    );
  }


  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String myTable, String id) async {
    Database db = await instance.database;
    return await db.delete(myTable, where: '$columnId = ?', whereArgs: [id]);
  }
}
