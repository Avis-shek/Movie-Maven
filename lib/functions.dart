// ignore_for_file: prefer_const_declarations

import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:tmdb_api/tmdb_api.dart';

class Functions {
  //Email Validation
  bool emailIsEmpty(String? email) {
    if (email == null || email.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool gmailValidation(String? email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@gmail\.com$');
    if (!emailRegex.hasMatch(email!)) {
      return false;
    } else {
      return true;
    }
  }

  String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password should be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password should contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password should contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password should contain at least one digit';
    }
    return null;
  }
}

// Define a function to fetch and print the genres of a movie
// Future<List> fetchMovieGenres(int movieId) async {
//   // Create an instance of the TMDB API with your API key and access token
//   final String apiKey = 'ef11befc41f663b7c9a0be08a3b18201';
//   final accessToken =
//       'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlZjExYmVmYzQxZjY2M2I3YzlhMGJlMDhhM2IxODIwMSIsInN1YiI6IjY0NmYxYmY5ODk0ZWQ2MDBiZjc3OGEyMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b57dzEUf5JgVrjGEBjovCfuUuwoAhZPQjkTLeFrLq8c';
//   final TMDB tmdb = TMDB(
//     ApiKeys(apiKey, accessToken),
//   );

//   final movieDetails = await tmdb.v3.movies.getDetails(movieId);
//   final List<dynamic> genres = movieDetails['genres'];
//   return genres;
// }


 Future<List<String>> loadMovieGenres(int movieId) async {
  final String apiKey = 'ef11befc41f663b7c9a0be08a3b18201';
    final url =
        'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey&append_to_response=genres';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final genres = body['genres'];
      if (genres != null) {
        final genreNames =
            genres.map((genre) => genre['name']).toList().cast<String>();
        return genreNames;
      }
    }
    return []; // Return an empty list if there's an error or if genres are not available
  }

Future<String?> fetchFullName(Database db, int userId) async {
  List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT fullName FROM users WHERE userId = ?
  ''', [userId]);

  if (results.isNotEmpty) {
    return results[0]['fullName'] as String?;
  }
  return null;
}