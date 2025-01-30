// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'movieDetails.dart';

class CategoryDes extends StatefulWidget {
  final String categoryId;

  const CategoryDes({super.key, required this.categoryId});
  @override
  _CategoryDesState createState() => _CategoryDesState();
}

class _CategoryDesState extends State<CategoryDes> {
  List MoviesList = [];
  late String _categoryId;
  @override
  void initState() {
    super.initState();
    _categoryId = widget.categoryId;
    fetchMoviesByCategory(int.parse(_categoryId));
  }

  Future<void> fetchMoviesByCategory(int categoryId) async {
    MoviesList = [];
    final url =
        'https://api.themoviedb.org/3/discover/movie?api_key=ef11befc41f663b7c9a0be08a3b18201&sort_by=popularity.desc&with_genres=$categoryId';
    String moviePosterUrl = '';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final movies = body['results'];

      setState(() {
        MoviesList = movies;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: _CustomClipper(),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Center(
              child: Text('Explore',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                    children: [
                      TextSpan(
                          text: 'Related ',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white)),
                      const TextSpan(text: 'Movies')
                    ]),
              ),
              SizedBox(height: 20),
              for (int i = 0; i < MoviesList.length; i++)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(
                          movieId: MoviesList[i]['id'].toString(),
                          poster: 'http://image.tmdb.org/t/p/w500/' +
                              MoviesList[i]['poster_path'],
                          name: MoviesList[i]['title'] != null
                              ? MoviesList[i]['title']
                              : 'Loading',
                          details: MoviesList[i]['overview'],
                          banner: 'http://image.tmdb.org/t/p/w500/' +
                              MoviesList[i]['backdrop_path'],
                          rating: MoviesList[i]['vote_average'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          children: [
                            Image.network(
                              'http://image.tmdb.org/t/p/w500/' +
                                  MoviesList[i]['poster_path'],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned.fill(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.red.withOpacity(0.3)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [0.6, 0.95])),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              bottom: 20,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 250.0,
                                    child: DefaultTextStyle(
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'Agne',
                                          fontWeight: FontWeight.bold),
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          TypewriterAnimatedText(
                                            MoviesList[i]['original_title'] !=
                                                    null
                                                ? MoviesList[i]
                                                    ['original_title']
                                                : 'Loading',
                                          ),
                                        ],
                                        totalRepeatCount: 100,
                                        pause:
                                            const Duration(milliseconds: 1000),
                                        displayFullTextOnTap: true,
                                        stopPauseOnTap: true,
                                      ),
                                    ),
                                  )
                                  // Text(
                                  // MoviesList[i]['original_title'] != null
                                  //   ? MoviesList[i]['original_title']
                                  //   : 'Loading',
                                  //     overflow: TextOverflow.ellipsis,
                                  //   style: Theme.of(context)
                                  //       .textTheme
                                  //       .headlineSmall!
                                  //       .copyWith(
                                  //           color: Colors.white,
                                  //           fontWeight: FontWeight.bold),
                                  // )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

// class _DidBuildListenable extends ChangeNotifier {
//   final GlobalKey key;

//   _DidBuildListenable(this.key);

//   @override
//   void addListener(VoidCallback listener) {
//     super.addListener(listener);
//     key.currentState?.context.visitChildElements((element) {
//       element.visitChildElements((element) {
//         if (element.widget is Scrollable) {
//           element.visitChildElements((element) {
//             if (element.widget is RawGestureDetector) {
//               final gestureDetector = element.widget as RawGestureDetector;
//               final gestureFactory =
//                   gestureDetector.gestures[VerticalDragGestureRecognizer]!
//                       as GestureRecognizerFactoryWithHandlers;
//               final recognizer = gestureFactory.constructor();
//               recognizer.addPointer(PointerDownEvent());
//             }
//           });
//         }
//       });
//     });
//   }
// }


// class _ParallaxFlowDelegate extends FlowDelegate {
//   final Listenable repaint;
//   final GlobalKey<ScrollableState> scrollableKey;
//   final BuildContext scrollableContext;
//   // final ScrollableState scrollable;
//   final BuildContext listenItemContext;
//   final GlobalKey backgroundImagekey;
//   final ScrollController scrollController;

//   _ParallaxFlowDelegate(
//       {required this.repaint,
//       required this.scrollableKey,
//       required this.scrollableContext,
//       required this.listenItemContext,
//       required this.backgroundImagekey,
//       required this.scrollController})
//       : super(repaint: repaint);

//   @override
//   void paintChildren(FlowPaintingContext context) {
//     // TODO: implement paintChildren

//     final scrollbleBox = scrollableContext.findRenderObject() as RenderBox;
//     final listItemBox = listenItemContext.findRenderObject() as RenderBox;
//     final listitemOffset = listItemBox.localToGlobal(
//         listItemBox.size.centerLeft(Offset.zero),
//         ancestor: scrollbleBox);

//     final viewportDimension = scrollController.position.viewportDimension;
//     final scrollFraction =
//         (listitemOffset.dy / viewportDimension).clamp(0.0, 0.1);

//     final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

//     final backgroudSize =
//         (backgroundImagekey.currentContext!.findRenderObject() as RenderBox)
//             .size;
//     final listItemSize = context.size;
//     final childRect =
//         verticalAlignment.inscribe(backgroudSize, Offset.zero & listItemSize);

//     context.paintChild(
//       0,
//       transform:
//           Transform.translate(offset: Offset(0.0, childRect.top)).transform,
//     );
//   }

//   @override
//   BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
//     return BoxConstraints.tightFor(width: constraints.maxWidth);
//   }

//   @override
//   bool shouldRepaint(covariant _ParallaxFlowDelegate oldDelegate) {
//     // TODO: implement shouldRepaint
//     return scrollableContext != oldDelegate.scrollableContext ||
//         listenItemContext != oldDelegate.listenItemContext ||
//         backgroundImagekey != oldDelegate.backgroundImagekey;
//   }
// }
