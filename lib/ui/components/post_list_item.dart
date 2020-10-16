import 'package:bloc_pattern/models/movie.dart';
import 'package:flutter/material.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({Key key, @required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(movie.title),
      subtitle: Text(movie.posterPath),
    );
  }
}
