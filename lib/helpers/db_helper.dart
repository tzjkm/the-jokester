// Import the sqflite package for SQLite database operations
import 'package:sqflite/sqflite.dart' as sql;
// Import the path package for path manipulation
import 'package:path/path.dart' as path;
// Import the sqlite_api package for SQLite database types
import 'package:sqflite/sqlite_api.dart';

// Define a DBHelper class for database operations
class DBHelper {
  // Define a list to hold the favorited jokes
  // Each joke is a map with String keys and values that can be any object
  static List<Map<String, Object?>> favoritedJokes = [];
  // Define a list to hold the user submitted jokes
  // Each joke is a map with String keys and values that can be any object
  static List<Map<String, Object?>> userSubmittedJokes = [];

  // Define a method to get the database
  static Future<Database> database() async {
    // Get the path to the database
    final dbPath = await sql.getDatabasesPath();
    // Open the database (and create it if it doesn't exist)
    return sql.openDatabase(path.join(dbPath, 'jokes.db'),
        onCreate: (db, version) async {
      // Create the 'favoritedJokes' table if it doesn't exist
      await db.execute(
          'CREATE TABLE favoritedJokes(id INTEGER PRIMARY KEY,content TEXT)');
      // Create the 'userJokes' table if it doesn't exist
      await db.execute(
          'CREATE TABLE userJokes(id INTEGER PRIMARY KEY,content TEXT)');
    }, version: 1);
  }

  // Define a method to get the user database
  static Future<Database> userDatabase() async {
    // Get the path to the database
    final dbPath = await sql.getDatabasesPath();
    // Open the database (and create it if it doesn't exist)
    return sql.openDatabase(path.join(dbPath, 'jokes.db'),
        onCreate: (db, version) async {
      // Create the 'userJokes' table if it doesn't exist
      await db.execute(
        'CREATE TABLE userJokes(id INTEGER PRIMARY KEY,content TEXT)',
      );
      // Create the 'jokes' table if it doesn't exist
      return db.execute(
        'CREATE TABLE jokes(id INTEGER PRIMARY KEY,content TEXT)',
      );
    }, version: 1);
  }

  // Define a method to insert data into a table
  static insert(String table, data) async {
    // Get the database
    final db = await DBHelper.database();
    // Insert the data into the table
    // If a row with the same primary key already exists, replace it
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // Update the list of favorited jokes
    DBHelper.favoritedJokes =
        await DBHelper.retrieveStoredJokes('favoritedJokes');
    // Update the list of user submitted jokes
    DBHelper.userSubmittedJokes =
        await DBHelper.retrieveStoredJokes('userJokes');
  }

  // Define a method to remove data from a table
  static remove(String table, data) async {
    // Get the database
    final db = await DBHelper.database();
    // Delete the row with the given id from the table
    await db.delete(table, where: 'id=?', whereArgs: [data['id']]);
    // Update the list of favorited jokes
    DBHelper.favoritedJokes = await DBHelper.retrieveStoredJokes(table);
    // Update the list of user submitted jokes
    DBHelper.userSubmittedJokes =
        await DBHelper.retrieveStoredJokes('userJokes');
  }

  // Define a method to retrieve jokes from a table
  static Future<List<Map<String, Object?>>> retrieveStoredJokes(
      String table) async {
    // Get the database
    final db = await DBHelper.database();
    // Query the table and get all rows
    final List<Map<String, Object?>> storedJokes = await db.query(table);
    // Return the list of jokes
    return storedJokes;
  }
}
