import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:permission_handler/permission_handler.dart';

List<Map<String, dynamic>> movieData = [];
List<List<int>> featureMatrix = [];
List<List<double>> similarityMatrix = [];

double cosineSimilarity(List<int> a, List<int> b) {
  int dotProduct = 0;
  double magnitudeA = 0;
  double magnitudeB = 0;

  for (int i = 0; i < a.length; i++) {
    dotProduct += a[i] * b[i];
    magnitudeA += pow(a[i], 2);
    magnitudeB += pow(b[i], 2);
  }
  return dotProduct / (sqrt(magnitudeA) * sqrt(magnitudeB));
}

void calculateSimilarityMatrix(Map<String, dynamic> args) {
  SendPort sendPort = args['sendPort'];
  List<List<int>> featureMatrix = args['featureMatrix'];
  List<Map<String, dynamic>> movieData = args['movieData'];

  // Calculate the similarity matrix
  List<List<double>> similarityMatrix = List.generate(
      movieData.length, (_) => List.filled(movieData.length, 0.0));

  for (int i = 0; i < movieData.length; i++) {
    for (int j = i + 1; j < movieData.length; j++) {
      double similarity = cosineSimilarity(featureMatrix[i], featureMatrix[j]);
      similarityMatrix[i][j] = similarity;
      similarityMatrix[j][i] = similarity;
    }
  }

  // Send the similarity matrix back to the main isolate
  sendPort.send(similarityMatrix);
}

Future<void> initialize() async {
  String csvData = await rootBundle.loadString('assets/images/main_data.csv');
  List<String> lines = csvData.split('\n');

  // Remove header row
  lines.removeAt(0);
  lines.removeLast();

  movieData = [];

  for (String line in lines) {
    List<String> values = line.split(',');

    Map<String, dynamic> movie = {
      'directorName': values[0],
      'actor1Name': values[1],
      'actor2Name': values[2],
      'actor3Name': values[3],
      'genres': values[4],
      'movieTitle': values[5],
      'comb': values[6],
    };

    movieData.add(movie);
  }

  // Create a list of unique genres
  List genres = movieData
      .map((movie) => movie['genres'].split('|'))
      .expand((i) => i)
      .toSet()
      .toList();

  // Create a feature matrix
  featureMatrix = movieData.map((movie) {
    List<int> row = List.filled(genres.length, 0);
    movie['genres'].split('|').forEach((genre) {
      int index = genres.indexOf(genre);
      row[index] = 1;
    });
    return row;
  }).toList();

  // Create an isolate
  ReceivePort receivePort = ReceivePort();
  Isolate isolate = await Isolate.spawn(
    calculateSimilarityMatrix,
    {
      'sendPort': receivePort.sendPort,
      'featureMatrix': featureMatrix,
      'movieData': movieData,
    },
  );

  // Listen for messages from the isolate
  receivePort.listen((message) {
    if (message is List<List<double>>) {
      // Update the similarity matrix
      similarityMatrix = message;

      // Kill the isolate
      isolate.kill();
    }
  });
}

List<String> makeRecommendation(String movieTitle, [List<String>? genres]) {
  // Find the index of the movie
  movieTitle = movieTitle.toLowerCase();
  int movieIndex =
      movieData.indexWhere((movie) => movie['movieTitle'] == movieTitle);
  if (movieIndex == -1) {
    // Movie not found, make a recommendation based on genres
    if (genres == null || genres.isEmpty) {
      return [];
    }
    List<Map<String, dynamic>> sortedMovies = List.from(movieData);
    sortedMovies.sort((a, b) {
      int countA = a['genres']
          .split('|')
          .where((genre) => genres.contains(genre))
          .length;
      int countB = b['genres']
          .split('|')
          .where((genre) => genres.contains(genre))
          .length;
      return countB.compareTo(countA);
    });

    // Return the top 5 recommended movies
    return (sortedMovies..shuffle())
        .sublist(0, 5)
        .map((movie) => movie['movieTitle'] as String)
        .toList();
  }

  // Make a recommendation
  List<double> similarities = similarityMatrix[movieIndex];
  List<Map<String, dynamic>> sortedMovies = List.from(movieData);
  sortedMovies.sort((a, b) {
    int indexA = movieData.indexOf(a);
    int indexB = movieData.indexOf(b);
    return similarities[indexB].compareTo(similarities[indexA]);
  });

  // Return the top 5 recommended movies
  return (sortedMovies..shuffle())
      .sublist(1, 6)
      .map((movie) => movie['movieTitle'] as String)
      .toList();
}
