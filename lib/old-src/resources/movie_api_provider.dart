import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

class MovieApiProvider {
  Client client = Client();
  // Don't put API key public in production
  final _apiKey = 'ccf8238443de219e8a1e7d8f38c6e57e';

  Future<Movies> fetchAllMovies() async {
    Movies movies = Movies();
    for (int i = 1; i <= 10; i++) {
      print("Page : $i");
      movies.add(await fetchMovieOnPage(page: i));
    }
    return movies;
  }

  Future<Movies> fetchMovieOnPage({@required int page}) async {
    final response = await client.get(
        "http://api.themoviedb.org/3/movie/popular?page=$page&api_key=$_apiKey");
    //.get("https://api.themoviedb.org/3/movie/550?api_key=$_apiKey");
    //print("Getting the JSON from API");
    //print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return Movies.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
