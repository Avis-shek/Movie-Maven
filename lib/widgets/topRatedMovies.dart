// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../movieDetails.dart';

class topRatedMovies extends StatefulWidget {
  const topRatedMovies({Key? key}) : super(key: key);

  @override
  _topRatedMovies createState() => _topRatedMovies();
}

class _topRatedMovies extends State<topRatedMovies> {
  List topRatedMovies = [];
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

    Map newRelease = await tmbdWithCustomeLog.v3.movies.getTopRated();
    setState(() {
      topRatedMovies = newRelease['results'];
    });
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
                "Top Rated Movies",
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
              for (int i = 1; i < topRatedMovies.length; i++)
                GestureDetector(
                  onTap: (){
                     // Navigate to the description page and pass the movie ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(
                            poster: 'http://image.tmdb.org/t/p/w500/' +
                                topRatedMovies[i]['poster_path'],
                            name: topRatedMovies[i]['title'] != null
                                ? topRatedMovies[i]['title']
                                : 'Loading',
                            details: topRatedMovies[i]['overview'],
                            banner: 'http://image.tmdb.org/t/p/w500/' +
                                topRatedMovies[i]['backdrop_path'],
                            movieId: topRatedMovies[i]['id'].toString(),
                            rating: topRatedMovies[i]['vote_average']),
                      ),
                    );
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              'http://image.tmdb.org/t/p/w500/' +
                                  topRatedMovies[i]['poster_path'],
                              height: 180,
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  topRatedMovies[i]['original_title'] != null
                                      ? topRatedMovies[i]['original_title']
                                      : 'Loading',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                // SizedBox(height: 5),
                                // Text(
                                //   "Movie Genre",
                                //   overflow: TextOverflow.ellipsis,
                                //   style: TextStyle(
                                //     color: Colors.white54,
                                //   ),
                                // ),
                                SizedBox(height: 8),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        topRatedMovies[i]['vote_average']
                                            .toStringAsFixed(1),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
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
