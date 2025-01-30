// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

class upcommingMoviesdWidget extends StatefulWidget {
  const upcommingMoviesdWidget({Key? key}) : super(key: key);

  @override
  _NewMoviesdWidgetState createState() => _NewMoviesdWidgetState();
}

class _NewMoviesdWidgetState extends State<upcommingMoviesdWidget> {
  List upcommingMovies = [];
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

    Map newRelease = await tmbdWithCustomeLog.v3.movies.getUpcoming();
    setState(() {
      upcommingMovies = newRelease['results'];
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
                "Not upcomming Movies",
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
                for (int i = 1; i < upcommingMovies.length; i++)
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        'http://image.tmdb.org/t/p/w500/' +
                            upcommingMovies[i]['poster_path'],
                        height: 180,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ],
            ))
      ],
    );
  }
}
