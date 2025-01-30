// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, dead_code, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unnecessary_null_comparison, use_build_context_synchronously, unnecessary_new, unused_import

import 'package:flutter/material.dart';
import 'package:movie_maveen/widgets/cusNavBar.dart';
import 'package:movie_maveen/widgets/moviePlayer.dart';
import 'package:movie_maveen/widgets/recommendationForYou.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'MyDatabse/connection.dart';
import 'models/goodBadClassifier.dart';
import 'widgets/movieDetailsButton.dart';
import 'package:launch_review/launch_review.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({
    Key? key,
    required this.movieId,
    required this.poster,
    required this.name,
    required this.details,
    required this.banner,
    required this.rating,
  }) : super(key: key);
  final String movieId;
  final String poster;
  final String name;
  final String details;
  final String banner;
  final double rating;

  @override
  _MovieDetails createState() => _MovieDetails();
}

class _MovieDetails extends State<MovieDetails> {
  YoutubePlayerController? _youtubeController;
  late String firstHalf;
  late String secondHalf;
  late TextEditingController reviewController;
  double ratingValue = 0.0;

  bool flag = true;
  late String review;

  late int movieId;
  late String poster;
  late String name;
  late String details;
  late String banner;
  late double rating;
  List Reviews = [];
  List reviewsFromUser = [];
  String videoUrl = '';
  Key currentKey = UniqueKey();

  final String apiKey = 'ef11befc41f663b7c9a0be08a3b18201';
  final accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZjExYmVmYzQxZjY2M2I3YzlhMGJlMDhhM2IxODIwMSIsInN1YiI6IjY0NmYxYmY5ODk0ZWQ2MDBiZjc3OGEyMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b57dzEUf5JgVrjGEBjovCfuUuwoAhZPQjkTLeFrLq8c';

  @override
  void initState() {
    super.initState();
    movieId = int.parse(widget.movieId);
    poster = widget.poster;
    name = widget.name;
    details = widget.details;
    banner = widget.banner;
    rating = widget.rating;
    Getreviews();
    loadReviews();
    reviewController = TextEditingController();

    // _youtubeController = YoutubePlayerController(
    //   initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
    //   flags: YoutubePlayerFlags(
    //     autoPlay: true,
    //     mute: false,
    //     hideControls: false,
    //     controlsVisibleAtStart: true,
    //     enableCaption: false,
    //   ),
    // );
  }

  Getreviews() async {
    reviewsFromUser = [];
    List UserReview = await getReviewsByMovieId(movieId.toString());
    setState(() {
      reviewsFromUser = UserReview;
    });
  }

  @override
  void dispose() {
    // Dispose of the TextEditingController
    reviewController.dispose();
    // _youtubeController?.dispose();
    super.dispose();
  }

  loadReviews() async {
    Reviews = [];
    TMDB tmbdWithCustomeLog = TMDB(ApiKeys(apiKey, accessToken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

    Map newRelease = await tmbdWithCustomeLog.v3.movies.getReviews(movieId);
    Map VideoUrl = await tmbdWithCustomeLog.v3.movies.getVideos(movieId);
    List<dynamic> reviews = newRelease['results'];
    List<dynamic> teasers = VideoUrl['results'];
    setState(() {
      Reviews = reviews;
      if (teasers.length != 0) {
        videoUrl = 'https://www.youtube.com/watch?v=' + teasers[0]['key'];
      } else {
        videoUrl = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.4,
              child: Image.network(
                banner,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              //Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.red.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 8)
                                ]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                poster,
                                height: 250,
                                width: 180,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(right: 50, top: 70),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.red,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.red.withOpacity(0.7),
                                        spreadRadius: 2,
                                        blurRadius: 8)
                                  ]),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MovieDetailsButton(movieId: movieId.toString()),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Action | Thriller ',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white54,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              rating.toStringAsFixed(1),
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 16,
                              ),
                            ),
                          ]),
                          SizedBox(height: 15),
                          Text(
                            details,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 20),
                          SizedBox(height: 20),
                          Center(
                            child: Text(
                              'Watch Trailer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 220,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red,
                                  offset: Offset(0, 0),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: videoUrl != null
                                  ? YoutubePlayer(
                                      controller: YoutubePlayerController(
                                        initialVideoId:
                                            YoutubePlayer.convertUrlToId(
                                                    videoUrl) ??
                                                '',
                                        flags: YoutubePlayerFlags(
                                          autoPlay: true,
                                          mute: false,
                                          hideControls: false,
                                          controlsVisibleAtStart: true,
                                          enableCaption: false,
                                        ),
                                      ),
                                      showVideoProgressIndicator: true,
                                      progressIndicatorColor: Colors.red,
                                      progressColors: const ProgressBarColors(
                                        playedColor: Colors.red,
                                        handleColor: Colors.red,
                                      ),
                                    )
                                  : Center(
                                      child: Text('No video available'),
                                    ),
                            ),
                          ),

                          // Container(
                          //   height: 220,
                          //   decoration: BoxDecoration(
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.red,
                          //         offset: Offset(0, 0),
                          //         blurRadius: 4.0,
                          //       ),
                          //     ],
                          //   ),
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(16.0),
                          //     child: YoutubePlayer(
                          //       controller: _youtubeController!,
                          //       showVideoProgressIndicator: true,
                          //       progressIndicatorColor: Colors.red,
                          //       progressColors: const ProgressBarColors(
                          //         playedColor: Colors.red,
                          //         handleColor: Colors.red,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    recMoviesdWidget(name: name, genre: 'Action'),
                    SizedBox(height: 30),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Reviews ",
                            style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          ),
                          // SizedBox(width: 5),
                          // Container(
                          //   width: 60,
                          //   height: 60,
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(30),
                          //     child: Image.asset(
                          //       'assets/images/reviw.png',
                          //       height: 60,
                          //       width: 60,
                          //     ),
                          //   ),
                          // ),
                          ElevatedButton(
                            onPressed: () {
                              _showReviewDialog();
                              // setState(() {});
                            },
                            child: Text(
                              'Add Review',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(
                                      color: Colors.red,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(key: currentKey, children: [
                      for (int i = 0; i < reviewsFromUser.length; i++)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: 30.0, start: 20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.asset(
                                            'assets/images/user.png',
                                            height: 60,
                                            width: 60,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: FutureBuilder<String>(
                                        future: fetchFullName(int.parse(
                                            reviewsFromUser[i]['userld'])),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            // While the future is loading, you can display a loading indicator or placeholder text
                                            return CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            // If there was an error in fetching the full name, you can display an error message
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            // If the future completed successfully, you can access the full name using snapshot.data
                                            return Text(
                                              snapshot.data ?? '',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      DescriptionTextWidget(
                                          text: reviewsFromUser[i]['review']),
                                      SizedBox(width: 5),
                                      // FutureBuilder<String>(
                                      //   future: predictedGoodBadAsync(
                                      //       reviewsFromUser[i]['review']),
                                      //   builder: (BuildContext context,
                                      //       AsyncSnapshot<String> snapshot) {
                                      //     if (snapshot.connectionState ==
                                      //         ConnectionState.waiting) {
                                      //       // While the future is loading, you can display a loading indicator or placeholder text
                                      //       return CircularProgressIndicator();
                                      //     } else if (snapshot.hasError) {
                                      //       // If there was an error in fetching the full name, you can display an error message
                                      //       return Text(
                                      //           'Error: ${snapshot.error}');
                                      //     } else {
                                      //       // If the future completed successfully, you can access the full name using snapshot.data
                                      //       return Text(
                                      //         snapshot.data ?? '',
                                      //         style: TextStyle(
                                      //           color: Colors.white70,
                                      //           fontSize: 16,
                                      //         ),
                                      //       );
                                      //     }
                                      //   },
                                      // ),

                                      Text(
                                          'Good',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                    ]),
                    Column(
                      children: [
                        for (int i = 0; i < Reviews.length; i++)
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: 30.0, start: 20.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Reviews[i]['author_details']
                                                        ['avatar_path'] !=
                                                    null
                                                ? Image.network(
                                                    'https://secure.gravatar.com/avatar/' +
                                                        Reviews[i][
                                                                'author_details']
                                                            ['avatar_path'],
                                                    height: 60,
                                                    width: 60,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      // Display fallback image from assets when the network image fails to load
                                                      return Image.asset(
                                                        'assets/images/fallback_image.jpg',
                                                        height: 60,
                                                        width: 60,
                                                      );
                                                    },
                                                  )
                                                : Image.asset(
                                                    'assets/images/user.png',
                                                    height: 60,
                                                    width: 60,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.0),
                                        child: Text(
                                          Reviews[i]['author'],
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        DescriptionTextWidget(
                                            text: Reviews[i]['content']),
                                        SizedBox(width: 5),
                                        //       FutureBuilder<String>(
                                        //   future: predictedGoodBadAsync(
                                        //       Reviews[i]['content']),
                                        //   builder: (BuildContext context,
                                        //       AsyncSnapshot<String> snapshot) {
                                        //     if (snapshot.connectionState ==
                                        //         ConnectionState.waiting) {
                                        //       // While the future is loading, you can display a loading indicator or placeholder text
                                        //       return CircularProgressIndicator();
                                        //     } else if (snapshot.hasError) {
                                        //       // If there was an error in fetching the full name, you can display an error message
                                        //       return Text(
                                        //           'Error: ${snapshot.error}');
                                        //     } else {
                                        //       // If the future completed successfully, you can access the full name using snapshot.data
                                        //       return Text(
                                        //         snapshot.data ?? '',
                                        //         style: TextStyle(
                                        //           color: Colors.white70,
                                        //           fontSize: 16,
                                        //         ),
                                        //       );
                                        //     }
                                        //   },
                                        // ),

                                        Text(
                                          'Good',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

// Method to display the pop-up dialog
  void _showReviewDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.black,
              title: Text(
                'Add Review',
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    cursorColor: Colors.red,
                    controller: reviewController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Review',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.red,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  RatingBar.builder(
                    initialRating: (ratingValue / 2)
                        .toDouble(), // Divide the rating by 2 to adjust from 1-10 to 1-5
                    minRating: 1,
                    maxRating: 10,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 40.0,
                    unratedColor: Colors.grey,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (value) {
                      setState(() {
                        rating = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // NewReview = '';
                    // isNewReview = false;
                    // Submit the review and rating values
                    String review = reviewController.text;
                    await insertReview(movieId.toString(), userId.toString(),
                        rating.toString(), review);
                    await Getreviews();
                    setState(() {
                      currentKey = UniqueKey();
                    });
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                  ),
                  child: Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  const DescriptionTextWidget({super.key, required this.text});

  @override
  DescriptionTextWidgetState createState() => DescriptionTextWidgetState();
}

class DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 100) {
      firstHalf = widget.text.substring(0, 100);
      secondHalf = widget.text.substring(100, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            flag ? (firstHalf + "...") : (firstHalf + secondHalf),
            style: TextStyle(color: Colors.white),
          ),
          if (secondHalf
              .isNotEmpty) // Only show the "show more" button when secondHalf is not empty
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    flag ? "show more" : "show less",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  flag = !flag;
                });
              },
            ),
        ],
      ),
    );
  }
}
