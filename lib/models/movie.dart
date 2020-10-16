import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Movie {
  String title;
  String posterPath;
  Uint8List image;

  Movie({@required this.title, @required this.posterPath});

  Movie.fromJson(jsonResult) {
    title = jsonResult['title'];
    posterPath = jsonResult['poster_path'];
  }

  static Future<Movie> loadImage(Movie movieNoImage) async {
    Movie movieWithImage =
        Movie(title: movieNoImage.title, posterPath: movieNoImage.posterPath);
    movieWithImage.image = (await NetworkAssetBundle(Uri.parse(
                'https://image.tmdb.org/t/p/w185${movieWithImage.posterPath}'))
            .load(""))
        .buffer
        .asUint8List();
    return movieWithImage;
  }
}
