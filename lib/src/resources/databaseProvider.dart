import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseProvider{
  static final _databaseName = "MyDatabase.db";
  static final table = "GymTable";
  static final _databaseVersion = 1;
  static final columnId = 'id';
  static final columnDate = 'date';
  static final columnBodyPart = 'bodyPart';
  static final columnImageData = 'imageData';

  // make this a singleton class
  DatabaseProvider._privateConstructor();
  static final DatabaseProvider instance = DatabaseProvider._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null){
      print("\t\t\tdatabase found \n");
      return _database;
    }
    print("\t\t\tdatabase not found \n");
    _database = await _initDatabase();
    return _database;
  }
  _initDatabase() async {
    return await openDatabase(
        join(await getDatabasesPath(),_databaseName),
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    print("\t\t\tmaking database\n");
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnDate TEXT,
            $columnBodyPart TEXT,
            $columnImageData BLOB
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // to get all items
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryFilteredRows(String filter) async {
    Database db = await instance.database;
    return await db.query(table, where: '$columnBodyPart = ?' , whereArgs: [filter]);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}