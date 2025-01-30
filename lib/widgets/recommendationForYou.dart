// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, override_on_non_overriding_member, camel_case_types, unused_element, prefer_const_declarations, unused_local_variable, file_names, prefer_interpolation_to_compose_strings, prefer_if_null_operators

import 'dart:convert';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:flutter/material.dart';
import 'package:movie_maveen/models/recommeder.dart';
import 'package:http/http.dart' as http;

import '../functions.dart';
import '../movieDetails.dart';

class recMoviesdWidget extends StatefulWidget {
  final String name;
  final String genre;
  const recMoviesdWidget({required this.name, required this.genre, Key? key})
      : super(key: key);
  @override
  _NewMoviesdWidgetState createState() => _NewMoviesdWidgetState();
}

class _NewMoviesdWidgetState extends State<recMoviesdWidget> {
  List RecomededMovies = [];
  late String _name;
  late String _genre;

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _genre = widget.genre;
    loadRecomendedMovies();
  }

  loadRecomendedMovies() async {
    RecomededMovies = [];
    final String apiKey = 'ef11befc41f663b7c9a0be08a3b18201';
    final accessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZjExYmVmYzQxZjY2M2I3YzlhMGJlMDhhM2IxODIwMSIsInN1YiI6IjY0NmYxYmY5ODk0ZWQ2MDBiZjc3OGEyMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b57dzEUf5JgVrjGEBjovCfuUuwoAhZPQjkTLeFrLq8c';
    if (_name == 'null') {
      TMDB tmbdWithCustomeLog = TMDB(ApiKeys(apiKey, accessToken),
          logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

      Map newRelease = await tmbdWithCustomeLog.v3.movies.getNowPlaying();

      List newReleases = newRelease['results'];

      for (int i = 0; i < newReleases.length; i++) {
        int movieId = newReleases[i]['id'];
        List<String> genres = await loadMovieGenres(movieId);
        newReleases[i]['genre_ids'] = genres;
      }
      if (mounted) {
        setState(() {
          RecomededMovies = newRelease['results'];
        });
      }
    } else {
      try {
        RecomededMovies = [];
        List recMove = [];
        List MovieTitle = makeRecommendation(_name, [_genre]);
        // print(MovieTitle);
        for (var i in MovieTitle) {
          if (i.contains('"""')) {
            i = i.replaceAll('"', '');
          }
          final apiKey = 'ef11befc41f663b7c9a0be08a3b18201';
          final query = Uri.encodeComponent(i);
          final url =
              'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=en-US&query=$query';

          final response = await http.get(Uri.parse(url));

          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);

            // Process the response and extract movie details
            final results = jsonResponse['results'];

            for (int i = 0; i < results.length; i++) {
              int movieId = results[i]['id'];
              List<String> genres = await loadMovieGenres(movieId);
              results[i]['genre_ids'] = genres;
            }

            if (results != null && results.isNotEmpty) {
              recMove.add(results[0]);
              // print(results[0]);
            } else {
              // Handle case when no results are found
            }
          } else {
            // Request failed
            print('Request failed with status: ${response.statusCode}');
          }
        }
        setState(() {
          RecomededMovies = recMove;
        });
      } catch (Exception) {
        print("Error Occured on recommendation");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommended",
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
              for (int i = 0; i < RecomededMovies.length; i++)
                InkWell(
                  onTap: () {
                    // Navigate to the description page and pass the movie ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(
                            poster: 'http://image.tmdb.org/t/p/w500/' +
                                RecomededMovies[i]['poster_path'],
                            name: RecomededMovies[i]['title'] != null
                                ? RecomededMovies[i]['title']
                                : 'Loading',
                            details: RecomededMovies[i]['overview'],
                            banner: 'http://image.tmdb.org/t/p/w500/' +
                                RecomededMovies[i]['backdrop_path'],
                            movieId: RecomededMovies[i]['id'].toString(),
                            rating: RecomededMovies[i]['vote_average']),
                      ),
                    );
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
                          blurRadius: 6,
                        ),
                      ],
                    ),
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
                                RecomededMovies[i]['poster_path'],
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
                                RecomededMovies[i]['original_title'] != null
                                    ? RecomededMovies[i]['original_title']
                                    : 'Loading',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                RecomededMovies[i]['genre_ids'].length >= 2
                                    ? RecomededMovies[i]['genre_ids']
                                        .sublist(0, 2)
                                        .join(" | ")
                                    : RecomededMovies[i]['genre_ids'].isNotEmpty
                                        ? RecomededMovies[i]['genre_ids'][0]
                                        : 'No genres available',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    RecomededMovies[i]['vote_average']
                                        .toStringAsFixed(1),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
