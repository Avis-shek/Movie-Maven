// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_null_comparison, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'movieDetails.dart';

class searchPage extends StatefulWidget {
  final String searchkey;
  const searchPage({Key? key, required this.searchkey}) : super(key: key);

  @override
  State<searchPage> createState() => _searchPage();
}

class _searchPage extends State<searchPage> {
  List topSearches = [];
  late String searchKey;
  String searchTerm = '';

  final String apiKey = 'ef11befc41f663b7c9a0be08a3b18201';
  final accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZjExYmVmYzQxZjY2M2I3YzlhMGJlMDhhM2IxODIwMSIsInN1YiI6IjY0NmYxYmY5ODk0ZWQ2MDBiZjc3OGEyMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b57dzEUf5JgVrjGEBjovCfuUuwoAhZPQjkTLeFrLq8c';

  @override
  void initState() {
    super.initState();
    searchKey = widget.searchkey;
    if (searchKey.isEmpty) {
      loadTopSerarchedMovies();
    } else {
      searchTerm = searchKey;
      loadSerarchedMovies(searchTerm);
    }
  }

  loadTopSerarchedMovies() async {
    TMDB tmbdWithCustomeLog = TMDB(ApiKeys(apiKey, accessToken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

    Map newRelease = await tmbdWithCustomeLog.v3.movies.getPopular();
    setState(() {
      topSearches = newRelease['results'];
    });
  }

  loadSerarchedMovies(String searchTerm) async {
    topSearches = [];
    TMDB tmdbWithCustomLog = TMDB(
      ApiKeys(apiKey, accessToken),
      logConfig: ConfigLogger(showLogs: true, showErrorLogs: true),
    );

    Map searchResult =
        await tmdbWithCustomLog.v3.search.queryMovies(searchTerm);
    setState(() {
      topSearches = searchResult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(topSearches);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press here
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Search For a movies",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                      )
                    ],
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
                    onTap: () {
                      loadSerarchedMovies(
                          searchTerm); // Pass the searchTerm to the method
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
                      onChanged: (value) {
                        setState(() {
                          searchTerm =
                              value.trim(); // Update the searchTerm variable with the typed text
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Visibility(
                visible: topSearches != null && topSearches.isNotEmpty,
                replacement: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/no result search icon_6511543.png',
                        height: 200,
                        width: 200,
                      ),
                      // SizedBox(height: 2),
                      Text(
                        'No Results Found',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                          shadows: [
                            Shadow(
                              color: Colors.white54,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                child: ListView.separated(
                  itemCount: topSearches.length,
                  separatorBuilder: (context, i) => SizedBox(height: 16),
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () {
                         // Navigate to the description page and pass the movie ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(
                            poster: 'http://image.tmdb.org/t/p/w500/' +
                                topSearches[i]['poster_path'],
                            name: topSearches[i]['title'] ?? 'Loading',
                            details: topSearches[i]['overview'],
                            banner: 'http://image.tmdb.org/t/p/w500/' +
                                topSearches[i]['backdrop_path'],
                            movieId: topSearches[i]['id'].toString(),
                            rating: topSearches[i]['vote_average']),
                      ),
                    );
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 140, top: 30),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8.0),
                            title: Text(
                              topSearches[i]['original_title'] ?? 'Loading',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Arvo',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              () {
                                try {
                                  final releaseDate = DateTime.parse(
                                      topSearches[i]['release_date']);
                                  return releaseDate.year.toString();
                                } catch (e) {
                                  return 'Invalid Date';
                                }
                              }(),
                              style: TextStyle(color: Colors.white54),
                            ),
                            trailing: Container(
                              width: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    topSearches[i]['vote_average']
                                        .toStringAsFixed(1),
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            height:
                                140, // Adjust the height as per your preference
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.7),
                                  blurRadius: 9,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ), // Adjust the width as per your preference
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius as per your preference
                  
                                    child: Image.network(
                                      'http://image.tmdb.org/t/p/w500/' +
                                          topSearches[i]['poster_path'],
                                      fit: BoxFit.cover,
                                      height:
                                          140, // Adjust the height as per your preference
                                      width: 130,
                                    ),
                                  ),
                                ),
                                // Rest of the ListTile content
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
