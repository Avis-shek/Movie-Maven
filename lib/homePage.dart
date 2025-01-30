// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_maveen/MyDatabse/connection.dart';
import 'package:movie_maveen/search.dart';
import 'package:movie_maveen/widgets/NewMoviesWidget.dart';
import 'package:movie_maveen/widgets/popularMovies.dart';
import 'package:movie_maveen/widgets/recommendationForYou.dart';
import 'package:movie_maveen/widgets/topRatedMovies.dart';
import 'package:movie_maveen/widgets/upCommingWidget.dart';
import 'movieDetails.dart';
import 'widgets/cusNavBar.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _editProfileState();
}

class _editProfileState extends State<homePage> {
  NewMoviesdWidget trending = NewMoviesdWidget();

  // void getUserDetailsFromDb() async {
  //   List<dynamic> userDetails = await getUserDetails(userId);
  String username = '';
  String searchTerm ='';
     
  // }

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    List<dynamic> userDetails = await getUserDetails(userId);
    setState(() {
      username = userDetails.isNotEmpty ? userDetails[0] : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    // String uFullname = getUserDetails(userId)[0] as String;
    // getUserDetailsFromDb();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // FutureBuilder<List<dynamic>> (
                        //   future: getUserDetails(userId),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.hasData) {
                        //       List<dynamic> userDetails = snapshot.data!;
                        //       username = userDetails[0];
                        //       return Text(username);
                        //     } else {
                        //       return CircularProgressIndicator();
                        //     }
                        //   },
                        // ),
                        Text(
                          "Hello  $username",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w500),
                        ),
                        const Text(
                          "what to watch?",
                          style: TextStyle(
                              color: Colors.white54,
                              // fontSize: 28,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profilePage');
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            'assets/images/user.png',
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF292B37),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => searchPage(searchkey:searchTerm) )
                          );
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    Container(
                      width: 300,
                      margin: EdgeInsets.only(left: 5),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle: TextStyle(color: Colors.white54)),
                             onChanged: (value) {
                        setState(() {
                          searchTerm =
                              value.trim(); // Update the searchTerm variable with the typed text
                        });
                      },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              upcommingMoviesdWidget(),
              SizedBox(
                height: 40,
              ),
              NewMoviesdWidget(),
              SizedBox(
                height: 40,
              ),
              recMoviesdWidget(name: 'null', genre: 'null'),
              SizedBox(
                height: 40,
              ),
              topRatedMovies(),
              SizedBox(
                height: 40,
              ),
              popularMovies(),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: CustomNavBar(index: 0,),
    );
  }
}
