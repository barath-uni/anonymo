import 'package:sqflite/sqflite.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserIdDb {

  var database;

  void insertUserId(String userid) async {
    final Database db = await database;
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
    print("Inside retrieve user id");
    final Database db = await database;
    var db_result = await db.query('UserId');
    print(db_result);
    if(db_result.length == 0) {
      print("Inside empty db result");
      return '';
    }
    final List<Map<String, dynamic>> maps = await db.query('UserId');
    print(maps[0]);
    return maps[0]['userid'] ?? '';

  }


  void initialise() async {
    database = openDatabase(
        join(await getDatabasesPath(), 'userid_data.db'),
        onCreate: (db, version) {
          return db.execute("CREATE TABLE UserId(userid TEXT PRIMARY KEY)");
        },
        version: 1
    );
  }



}