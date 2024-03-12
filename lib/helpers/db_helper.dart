import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static List<Map<String, Object?>> favoritedJokes = [];
  static List<Map<String, Object?>> userSubmittedJokes = [];

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'jokes.db'),
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE favoritedJokes(id INTEGER PRIMARY KEY,content TEXT)');
      await db.execute(
          'CREATE TABLE userJokes(id INTEGER PRIMARY KEY,content TEXT)');
    }, version: 1);
  }

  // static Future<Database> userDatabase() async {
  //   // This will store user submitted jokes
  //   final dbPath = await sql.getDatabasesPath();
  //   return sql.openDatabase(path.join(dbPath, 'jokes.db'),
  //       onCreate: (db, version) async {
  //     await db.execute(
  //       'CREATE TABLE userJokes(id INTEGER PRIMARY KEY,content TEXT)',
  //     );

  //     return db.execute(
  //       'CREATE TABLE jokes(id INTEGER PRIMARY KEY,content TEXT)',
  //     );
  //   }, version: 1);
  // }

//   static insert(String table, data) async {
//     // using it as both updating and insert first time
//     final db = await DBHelper.database();
//     await db.insert(
//       table,
//       data,
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     DBHelper.favoritedJokes =
//         await DBHelper.retrieveStoredJokes('favoritedJokes');
//     DBHelper.userSubmittedJokes =
//         await DBHelper.retrieveStoredJokes('userJokes');
//   }

// //There is some code duplication here regarding same methods can be used for storing and removing data for both tables
//   static remove(String table, data) async {
//     final db = await DBHelper.database();
//     await db.delete(table, where: 'id=?', whereArgs: [data['id']]);
//     DBHelper.favoritedJokes = await DBHelper.retrieveStoredJokes(table);
//     DBHelper.userSubmittedJokes =
//         await DBHelper.retrieveStoredJokes('userJokes');
//   }

  static insert(String table, data) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static remove(String table, data) async {
    final db = await DBHelper.database();
    await db.delete(table, where: 'id=?', whereArgs: [data['id']]);
  }

// Used for retrieving both favorited and user jokes.
  static Future<List<Map<String, Object?>>> retrieveStoredJokes(
      String table) async {
    final db = await DBHelper.database();
    final List<Map<String, Object?>> storedJokes = await db.query(table);
    return storedJokes;
  }
}
