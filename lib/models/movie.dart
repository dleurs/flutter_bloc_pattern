import 'package:flutter/material.dart';

class Movie {
  String _title;
  String _posterPath;

  Movie(jsonResult) {
    _title = jsonResult['title'];
    _posterPath = jsonResult['poster_path'];
  }

  String get title => _title;
  String get posterPath => _posterPath;
}
