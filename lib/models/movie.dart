import 'package:flutter/material.dart';

class Movie {
  String title;
  String posterPath;
  Image image;

  //Movie({@required this.title, @required this.posterPath});

  Movie.fromJson(jsonResult) {
    title = jsonResult['title'];
    posterPath = jsonResult['poster_path'];
  }
}
