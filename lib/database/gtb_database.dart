import 'package:get_that_bread/database/database_helper.dart';

class GtbDatabase {
  // make this a singleton class
  GtbDatabase._privateConstructor();
  static final GtbDatabase instance = GtbDatabase._privateConstructor();
  DatabaseHelper dh = DatabaseHelper.instance;

  
}