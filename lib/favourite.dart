// ignore_for_file: prefer_const_constructors, unnecessary_new, sort_child_properties_last, prefer_if_null_operators, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_maveen/categoryDes.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'dart:convert';
import 'MyDatabse/connection.dart';
import 'movieDetails.dart';
import 'widgets/cusNavBar.dart';

class favouritePage extends StatefulWidget {
  const favouritePage({super.key});

  @override
  State<favouritePage> createState() => _favouritePage();
}

class _favouritePage extends State<favouritePage> {
  @override
  List favMovies = [];
  List favList = [];
  final String apiKey = 'ef11befc41f663b7c9a0be08a3b18201';
  final accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZjExYmVmYzQxZjY2M2I3YzlhMGJlMDhhM2IxODIwMSIsInN1YiI6IjY0NmYxYmY5ODk0ZWQ2MDBiZjc3OGEyMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b57dzEUf5JgVrjGEBjovCfuUuwoAhZPQjkTLeFrLq8c';

  @override
  void initState() {
    super.initState();
    loadFavlist();
  }

  void deleteFavoriteList(int userId, String movieId, int index) async {
    // Delete the record from the database
    deleteFavorite(userId, movieId);

    // Remove the item from the favList
    setState(() {
      favList.removeAt(index);
    });
  }

  loadFavlist() async {
    final watchlistData = await getFavlistByUserId(userId.toString());
    for (var row in watchlistData) {
      final movieId = row['movield'];
      final url = 'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse != null && jsonResponse.isNotEmpty) {
          favMovies.add(jsonResponse);
        } else {
          // Handle case when no results are found
          print('No movies found');
        }
      } else {
        // Request failed
        print('Request failed with status: ${response.statusCode}');
      }
    }
    setState(() {
      favList = favMovies;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: new Text(
          'Movies',
          style: new TextStyle(
              color: Colors.white,
              fontFamily: 'Arvo',
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          new Icon(
            Icons.menu,
            color: Colors.white,
          )
        ],
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new MovieTitle(Colors.black),
            new Expanded(
              child: new ListView.builder(
                  itemCount: favList == null ? 0 : favList.length,
                  itemBuilder: (context, i) {
                    return new Container(
                      child: new MovieCell(
                        movies: favList,
                        i: i,
                        onDelete: deleteFavoriteList,
                      ),
                      padding: const EdgeInsets.all(0.0),
                      color: Colors.black,
                    );
                  }),
            )
          ],
        ),
      ),
      // bottomNavigationBar: CustomNavBar(index: 2,),
    );
  }
}

class MovieTitle extends StatelessWidget {
  final Color mainColor;

  MovieTitle(this.mainColor);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 30.0),
      child: new Text(
        'My Favourites',
        style: new TextStyle(
            fontSize: 25.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arvo'),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class MovieCell extends StatefulWidget {
  final movies;
  final i;
  final Function onDelete;

  const MovieCell({super.key, this.movies, this.i, required this.onDelete});

  @override
  State<MovieCell> createState() => _MovieCell();
}

class _MovieCell extends State<MovieCell> {
  late final movies;
  late final i;
  late Function deleteFavList;

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    i = widget.i;
    deleteFavList = widget.onDelete;
  }

  Color mainColor = Colors.white;
  var image_url = 'https://image.tmdb.org/t/p/w500/';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(
              poster:
                  'http://image.tmdb.org/t/p/w500/' + movies[i]['poster_path'],
              name: movies[i]['title'] != null ? movies[i]['title'] : 'Loading',
              details: movies[i]['overview'],
              banner: 'http://image.tmdb.org/t/p/w500/' +
                  movies[i]['backdrop_path'],
              movieId: movies[i]['id'].toString(),
              rating: movies[i]['vote_average'],
            ),
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                  ),
                 decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.red,
                    image: DecorationImage(
                      image: movies[i]['poster_path'] != null
                          ? NetworkImage(image_url + movies[i]['poster_path'])
                          : AssetImage(
                                  'assets/images/canva-black-&-white-modern-mystery-forest-movie-poster-rLty9dwhGG4.jpg')
                              as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.red,
                        blurRadius: 5.0,
                        offset: Offset(2.0, 5.0),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: Column(
                    children: [
                      Text(
                        movies[i]['original_title'] != null
                            ? movies[i]['original_title']
                            : 'Loading',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Arvo',
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                      Padding(padding: const EdgeInsets.all(2.0)),
                      Text(
                        movies[i]['overview'],
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Arvo',
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  deleteFavList(userId, movies[i]['id'].toString(), i);
                  // setState(() {
                  //   movies.removeAt(i);
                  // });
                },
              ),
            ],
          ),
          Container(
            width: 300.0,
            height: 0.5,
            color: Colors.red,
            margin: const EdgeInsets.all(16.0),
          ),
        ],
      ),
    );
  }
}
