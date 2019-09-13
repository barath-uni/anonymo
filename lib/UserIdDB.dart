import 'package:sqflite/sqflite.dart';

import 'dart:async';

import 'package:path/path.dart';

class UserIdDb {

  static Database _db;

  Future<Database> get dataBase async {
    if (_db != null) return _db;
    _db = await initialise();
    return _db;
  }

  void insertUserId(String userid) async {
    final Database db = await dataBase;
    if (userid != null) {
      await db.insert(
        'UserId',
        {'userid': userid},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    print(await this.retrieveUserId());
  }

  Future<String> retrieveUserId()
  async{
    final Database db = await dataBase;
    var db_result = await db.query('UserId');
    print(db_result);
    if(db_result == null || db_result.length == 0) {
      print("Inside empty db result");
      return '';
    }
    final List<Map<String, dynamic>> maps = await db.query('UserId');
    print(maps[0]);
    return maps[0]['userid'] ?? '';

  }


  initialise() async {
    var database = openDatabase(
        join(await getDatabasesPath(), 'userid_data.db'),
        onCreate: (db, version) {
          return db.execute("CREATE TABLE UserId(userid TEXT PRIMARY KEY)");
        },
        version: 1
    );
    print("Object of database");
    print(database);
    return database;
  }



}