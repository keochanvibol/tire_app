import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'datauser.dart';

String table = 'user';

class ConnectionDB {
  Future<Database> initializeDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String part = await getDatabasesPath();
    return openDatabase(
      join(part, 'tododatabase.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE $table(id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(User user) async {
    final db = await initializeDB();
    await db.insert(table, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('Function Insert');
  }

  Future<List<User>> getUser() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query(table);
    return queryResult.map((e) => User.fromMap(e)).toList();
    //queryResult.map((e) => todo.fromMap(e)).toList();
  }

  Future<void> updateUser(User user) async {
    final db = await initializeDB();
    await db.update(table, user.toMap(), where: 'id=?', whereArgs: [user.id]);
  }

  Future<void> deleteUser(int id) async {
    final db = await initializeDB();
    await db.delete(table, where: 'id=?', whereArgs: [id]);
  }
}