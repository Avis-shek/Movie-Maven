// ignore_for_file: unused_element, unused_local_variable

import 'package:flutter/widgets.dart';
import 'package:movie_maveen/MyDatabse/review.dart';
import 'package:movie_maveen/MyDatabse/watchList.dart';
import 'package:sqflite/sqflite.dart';
import 'favourite.dart';
import 'subscriptionModel.dart';
import 'user.dart';

bool userselected = false;
int userId = -1;
String userfullname = '';
String email = '';

Future<Database> getDatabase() async {
  // Get a reference to the database
  var db = await openDatabase('getfit_database.db');
  print('THIS IS PATH = $db');
  return db;
}

//For inserting newly registered user data to database
Future<void> insertUser(
    List<String> controllers, GlobalKey<FormState> formKey) async {
  WidgetsFlutterBinding.ensureInitialized();
  Database db = await getDatabase();
  List<TextEditingController> controllerList =
      controllers.cast<TextEditingController>();
  // Delete the users table from the database
  // await deleteTable('users',db);
  await createUsersTable(db);
  // Create a new user
  final newUser = User(
      fullName: controllerList[0].text,
      email: controllerList[1].text,
      passwrd: controllerList[2].text,
      number: "");
  await db.insert('users', newUser.toMap());

  //FOR TABLES LIST
  Future<List<String>> getTables() async {
    // Query the sqlite_master table to get a list of all tables
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');

    // Convert the result into a List<String>
    return result.map((row) => row['name'] as String).toList();
  }

  // Get a list of all tables in the database
  final tables = await getTables();

  // Print the list of tables
  // ignore: avoid_print
  print('List of tables: $tables');

  //fetching inserted user data
  Future<List<User>> getUsers() async {
    // Query the users table
    final List<Map<String, dynamic>> maps =
        await db.query('users', orderBy: 'userId ASC');

    // Convert the List<Map<String, dynamic>> into a List<User>
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  // // creates a user table
  // // Define a function to insert a user into the database
  // Future<void> insertUser(User user) async {
  //    createUsersTable(db);
  //   // Insert the user into the users table
  //   try {
  //     await db.insert('users', user.toMap());
  //   } on DatabaseException catch (e) {
  //     if (e.isUniqueConstraintError()) {
  //       if (formKey.currentState!.validate()) {
  //         showEmailExistsError(controllerList[1].text);
  //         return;
  //       }
  //     } else {
  //       // ignore: avoid_print
  //       print('Error inserting user: $e');
  //       return;
  //     }
  //   }
  // }
  // / Retrieve all users from the database
  final users = await getUsers();

  // // Print the list of users
  // ignore: avoid_print
  print(users.toString());

  // Insert the new user into the database
  // await insertUser(newUser);

  // Future<List<User>> confirmUser(){

  // }
}

Future<bool> emailExists(String email) async {
  // Replace with your own code to query the SQLite database
  Database db = await getDatabase();
  var result =
      await db.rawQuery('SELECT * FROM users WHERE email = ?', [email]);
  return result.isNotEmpty;
}

Future<void> createUsersTable(Database db) async {
  await db.execute('''
      CREATE TABLE IF NOT EXISTS users(
        userId INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT,
        email TEXT UNIQUE,
        passwrd TEXT,
        number TEXT
      )
    ''');
}

// Define a function to delete a table from the database
Future<void> deleteTable(String tableName, Database db) async {
  // Execute a DROP TABLE statement to delete the table
  await db.execute('DROP TABLE IF EXISTS $tableName');
}

Future<void> selectUsers(String email, String password) async {
  // WidgetsFlutterBinding.ensureInitialized();
  Database db = await getDatabase();
  // Query the users table
  final List<Map<String, dynamic>> maps = await db.query(
    'users',
    columns: ['userId'],
    where: 'email = ? AND passwrd = ?',
    whereArgs: [email, password],
  );
  if (maps.isNotEmpty) {
    userselected = true;
    userId = maps.first['userId'] as int;
  }
}

Future<List> getUserDetails(int userId) async {
  Database db = await getDatabase();
  if (userId != -1) {
    final List<Map<String, dynamic>> userDetails = await db.query(
      'users',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    if (userDetails.isNotEmpty) {
      Map<String, dynamic> user = userDetails.first;
      userfullname = user['fullName'].toString();
      email = user['email']?.toString() ?? '';
    }
  } else {
    print("Invalid userId");
  }
  return List.from([userfullname]);
  // or you can return an empty map or handle the absence of user details in a different way
}

//to Get info about the user

// Convert the List<Map<String, dynamic>> into a List<User>
// return List.generate(maps.length, (i) {
//   return User.fromMap(maps[i]);
// });
// int rownum = 1;
//   for (var row in maps1) {
//     print("This is User ID: $row of row $rownum");
//     rownum++;
//   }

Future<void> createWatchTable(Database db) async {
  await db.execute('''
      CREATE TABLE IF NOT EXISTS watchlist(
        watchLaterld INTEGER PRIMARY KEY AUTOINCREMENT,
        movield TEXT,
        userld TEXT 
      )
    ''');
}

Future<void> insertWatchlist(String movieId, String userId) async {
  Database db = await getDatabase();
  await createWatchTable(db);
  final newUser = watchlist(movield: movieId, userld: userId);
  await db.insert('watchlist', newUser.toMap());
}

Future<List<Map<String, dynamic>>> getWatchlistByUserId(String userId) async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> watchlist = await db.query(
    'watchlist',
    where: 'userld = ?',
    whereArgs: [userId],
  );
  return watchlist;
}

// Favourite

Future<void> createFavoiriteTable(Database db) async {
  await db.execute('''
      CREATE TABLE IF NOT EXISTS favourite(
        favouriteld INTEGER PRIMARY KEY AUTOINCREMENT,
        movield TEXT,
        userld TEXT 
      )
    ''');
}

Future<void> insertFavouriteist(String movieId, String userId) async {
  Database db = await getDatabase();
  await createFavoiriteTable(db);
  final newUser = favourite(movield: movieId, userld: userId);
  await db.insert('favourite', newUser.toMap());
}

Future<List<Map<String, dynamic>>> getFavlistByUserId(String userId) async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> favList = await db.query(
    'favourite',
    where: 'userld = ?',
    whereArgs: [userId],
  );
  return favList;
}

Future<void> createReviewTable(Database db) async {
  await db.execute('''
      CREATE TABLE IF NOT EXISTS review(
        reviewld INTEGER PRIMARY KEY AUTOINCREMENT,
        movield TEXT,
        userld TEXT,
        rating TEXT,
        review TEXT
      )
    ''');
}

Future<void> insertReview(
    String movieId, String userId, String rating, String review) async {
  Database db = await getDatabase();
  await createReviewTable(db);
  final reviewRating =
      Review(movield: movieId, userld: userId, rating: rating, review: review);
  await db.insert('review', reviewRating.toMap());
}

Future<List<Map<String, dynamic>>> getReviewsByMovieId(String movieId) async {
  Database db = await getDatabase();

  // Query the database for reviews with the specified movie ID
  List<Map<String, dynamic>> maps = await db.query(
    'review',
    where: 'movield = ?',
    whereArgs: [movieId],
    orderBy: 'reviewld DESC',
  );

  return maps;
}

Future<String> fetchFullName(int userId) async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT fullName FROM users WHERE userId = ?
  ''', [userId]);
  return results[0]['fullName'];
}

Future<void> deleteFavorite(int userId, String movieId) async {
  final db = await getDatabase();

  await db.delete(
    'favourite',
    where: 'userld = ? AND movield = ?',
    whereArgs: [userId.toString(), movieId],
  );
}

Future<void> deleteFromWatchlist(int userId, String movieId) async {
  final db =
      await getDatabase(); // Replace 'getDatabase()' with your database instance retrieval method

  await db.delete(
    'watchlist',
    where: 'userld = ? AND movield = ?',
    whereArgs: [userId.toString(), movieId],
  );
}

Future<void> createSubscriptionTable(Database db) async {
  await db.execute('''
      CREATE TABLE IF NOT EXISTS subscription(
        subscriptionld INTEGER PRIMARY KEY AUTOINCREMENT,
        userld TEXT,
        modelname TEXT
      )
    ''');
}

Future<void> insertSubscription(String userid, String modelname) async {
  Database db = await getDatabase();
  await createSubscriptionTable(db);

  final subscription = Subscription(userld: userid, modelname: modelname);
  await db.insert('subscription', subscription.toMap());
}

Future<List<Map<String, dynamic>>> getSubscriptionsByUserId(
    String userId) async {
  final db = await getDatabase();
  final List<Map<String, dynamic>> result = await db.query(
    'subscription',
    where: 'userld = ?',
    whereArgs: [userId],
  );
  return result;
}
