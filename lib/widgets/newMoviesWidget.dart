// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, unused_element, no_logic_in_create_state, must_be_immutable, prefer_interpolation_to_compose_strings, prefer_if_null_operators, prefer_typing_uninitialized_variables
import 'package:movie_maveen/models/recommeder.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:flutter/material.dart';
import 'package:movie_maveen/functions.dart';
import '../movieDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewMoviesdWidget extends StatefulWidget {
  const NewMoviesdWidget({Key? key}) : super(key: key);

  @override
  _NewMoviesdWidgetState createState() => _NewMoviesdWidgetState();
}

class _NewMoviesdWidgetState extends State<NewMoviesdWidget> {
  Functions function = Functions();
  late final categories;
  List trendingMovies = [];
  final String apiKey = 'ef11befc41f663b7c9a0be08a3b18201';
  final accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZjExYmVmYzQxZjY2M2I3YzlhMGJlMDhhM2IxODIwMSIsInN1YiI6IjY0NmYxYmY5ODk0ZWQ2MDBiZjc3OGEyMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b57dzEUf5JgVrjGEBjovCfuUuwoAhZPQjkTLeFrLq8c';

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  loadMovies() async {
    TMDB tmbdWithCustomeLog = TMDB(ApiKeys(apiKey, accessToken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

    Map newRelease = await tmbdWithCustomeLog.v3.trending.getTrending();

    List newReleases = newRelease['results'];

    for (int i = 0; i < newReleases.length; i++) {
      int movieId = newReleases[i]['id'];
      List<String> genres = await loadMovieGenres(movieId);
      newReleases[i]['genre_ids'] = genres;
    }

    if (mounted) {
      setState(() {
        trendingMovies = newReleases;
      });
    }
  }

  Widget TrendingMovies() {
    // print(trendingMovies);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Trending Movies",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int i = 0; i <= trendingMovies.length - 1; i++)
                InkWell(
                  onTap: () {
                    // Navigate to the description page and pass the movie ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(
                            poster: 'http://image.tmdb.org/t/p/w500/' +
                                trendingMovies[i]['poster_path'],
                            name: trendingMovies[i]['title'] != null
                                ? trendingMovies[i]['title']
                                : 'Loading',
                            details: trendingMovies[i]['overview'],
                            banner: 'http://image.tmdb.org/t/p/w500/' +
                                trendingMovies[i]['backdrop_path'],
                            movieId: trendingMovies[i]['id'].toString(),
                            rating: trendingMovies[i]['vote_average']),
                      ),
                    );
                    // Navigator.pushNamed(context, '/movieDetails');
                  },
                  child: Container(
                    height: 300,
                    width: 190,
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Color(0xFF292B37),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF292B37).withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 6)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          child: Image.network(
                            'http://image.tmdb.org/t/p/w500/' +
                                trendingMovies[i]['poster_path'],
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trendingMovies[i]['title'] != null
                                      ? trendingMovies[i]['title']
                                      : 'Loading',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      height: 1,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  trendingMovies[i]['genre_ids'].length >= 2
                                      ? trendingMovies[i]['genre_ids']
                                          .sublist(0, 2)
                                          .join(" | ")
                                      : trendingMovies[i]['genre_ids']
                                              .isNotEmpty
                                          ? trendingMovies[i]['genre_ids'][0]
                                          : 'No genres available',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white54,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      trendingMovies[i]['vote_average']
                                          .toStringAsFixed(1),
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return TrendingMovies();
  }
}
