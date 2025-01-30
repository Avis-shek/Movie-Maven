// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_maveen/categoryDes.dart';
import 'dart:convert';
import 'widgets/cusNavBar.dart';

class categoryPage extends StatefulWidget {
  const categoryPage({super.key});

  @override
  State<categoryPage> createState() => _categoryPage();
}

class _categoryPage extends State<categoryPage> {
  final apiKey = 'ef11befc41f663b7c9a0be08a3b18201';
  final baseUrl = Uri.parse('https://api.themoviedb.org/3');
  List MoviesCategory = [];
  List categoryPoster = [];
  List prePoster = [];
  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    MoviesCategory = [];
    categoryPoster = [];
    prePoster = [];
    List catList = [];
    final url = 'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final categories = body['genres'];
      for (var category in categories) {
        final categoryImageUrl = await fetchMoviesByCategory(category['id']);
        catList.add(categoryImageUrl);
      }
      // Do something with the fetched categories
      // print(categories);
      setState(() {
        MoviesCategory = categories;
        categoryPoster = catList;
      });
      // print(MoviesCategory);
    } else {
      // Handle the error
      print('Failed to fetch categories. Status code: ${response.statusCode}');
    }
  }

  Future<String> fetchMoviesByCategory(int categoryId) async {
    final url =
        'https://api.themoviedb.org/3/discover/movie?api_key=ef11befc41f663b7c9a0be08a3b18201&sort_by=popularity.desc&with_genres=$categoryId';
    String moviePosterUrl = '';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final movies = body['results'];

      if (movies.isNotEmpty) {
        final movie = movies[0];
        final posterPath = movie['poster_path'];
        if (!prePoster.contains(posterPath)) {
          moviePosterUrl = 'https://image.tmdb.org/t/p/w500$posterPath';
          prePoster.add(posterPath);
        } else {
          final movie = movies[2];
          final posterPath = movie['poster_path'];
          moviePosterUrl = 'https://image.tmdb.org/t/p/w500$posterPath';
          prePoster.add(posterPath);
        }
      }
    } else {
      print('Failed to fetch movies. Status code: ${response.statusCode}');
    }
    return moviePosterUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // ignore: prefer_const_literals_to_create_immutables
            colors: [
              Colors.red,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.red,
            ],
          ),
          //borderRadius: BorderRadius.circular(55.0),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 30),
                      Center(
                        child: Text(
                          "Discover",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(MoviesCategory.length, (index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryDes(
                                  categoryId:
                                      MoviesCategory[index]['id'].toString()),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  categoryPoster[index],
                                  height: 100,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                MoviesCategory[index]['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: CustomNavBar(index: 1),
    );
  }
}
