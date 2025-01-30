// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_maveen/MyDatabse/connection.dart';

class MovieDetailsButton extends StatelessWidget {
  final String movieId;

  MovieDetailsButton({required this.movieId});

  Future<bool> isAddedtoWatchlist() async {
    final watchlistData = await getWatchlistByUserId(userId.toString());

    for (var row in watchlistData) {
      final movieid = row['movield'];
      if (movieid == movieId) {
        return true;
      }
    }
    ;
    return false;
  }

  Future<bool> isAddedtofav() async {
    final watchlistData = await getFavlistByUserId(userId.toString());
    for (var row in watchlistData) {
      final movieid = row['movield'];
      if (movieid == movieId) {
        return true;
      }
    }
    ;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              if (await isAddedtoWatchlist()) {
                Fluttertoast.showToast(
                    msg: "Already Added",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                insertWatchlist(movieId, userId.toString());
                Fluttertoast.showToast(
                    msg: "Added To WatchList",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xFF292B37),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF292B37),
                        spreadRadius: 1,
                        blurRadius: 4)
                  ]),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (await isAddedtofav()) {
                Fluttertoast.showToast(
                    msg: "Already Added",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                insertFavouriteist(movieId, userId.toString());
                Fluttertoast.showToast(
                    msg: "Added To Favourite",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xFF292B37),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF292B37),
                        spreadRadius: 1,
                        blurRadius: 4)
                  ]),
              child: Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xFF292B37),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF292B37), spreadRadius: 1, blurRadius: 4)
                ]),
            child: Icon(
              Icons.download,
              color: Colors.white,
              size: 35,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xFF292B37),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF292B37), spreadRadius: 1, blurRadius: 4)
                ]),
            child: Icon(
              Icons.share,
              color: Colors.white,
              size: 35,
            ),
          )
        ],
      ),
    );
  }
}
