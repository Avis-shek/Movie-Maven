// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_maveen/category.dart';
import 'package:movie_maveen/login.dart';
import 'package:movie_maveen/models/recommeder.dart';
import 'package:movie_maveen/otpScreen.dart';
import 'package:movie_maveen/payment.dart';
import 'package:movie_maveen/resetPassword.dart';
import 'package:movie_maveen/search.dart';
import 'package:movie_maveen/watchlist.dart';
import 'package:movie_maveen/widgets/cusNavBar.dart';
import 'package:sqflite/sqflite.dart';

import 'MyDatabse/connection.dart';
import 'categoryDes.dart';
import 'editProfile.dart';
import 'favourite.dart';
import 'forgetPassword.dart';
import 'homePage.dart';
import 'movieDetails.dart';
import 'profile.dart';
import 'subscription.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
  initialize();
}

//  @override
//   void initState() {

//   }
class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<void> tableCreation() async {
      Database db = await getDatabase();
      // deleteTable('review', db);
      createUsersTable(db);
      createWatchTable(db);
      createFavoiriteTable(db);
      createReviewTable(db);
      createSubscriptionTable(db);
    }

    tableCreation();
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: '/login',
      routes: {
        '/homePage': (context) => NavPageView(),
        // '/movieDetails': (context) => MovieDetails(),
        '/category': (context) => categoryPage(),
        '/profilePage': (context) => ProfilePage(),
        '/editProfile': (context) => EditProfilePage(),
        '/ChangePasswordPage': (context) => ChangePasswordPage(),
        '/forgetPassword': (context) => forgetPassword(),
        '/login': (context) => Login(),
        '/watchListPage': (context) => watchListPage(),
        '/favouritePage': (context) => favouritePage(),
        '/Subscription': (context) => Subscription(
              title: 'Subscription Model',
            ),
        '/Payment': (context) => Payment(modelName: '', price: ''),
        // '/SearchPage': (context) => searchPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
