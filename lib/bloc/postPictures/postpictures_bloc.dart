import 'dart:async';
import 'package:bloc_pattern/models/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'postpictures_event.dart';
part 'postpictures_state.dart';

// TODO: Don't let private key like this visible
final apiKey = 'ccf8238443de219e8a1e7d8f38c6e57e';

class PostpicturesBloc extends Bloc<PostpicturesEvent, PostpicturesState> {
  PostpicturesBloc({@required this.httpClient}) : super(PostpicturesInitial());

  final http.Client httpClient;

  @override
  Stream<PostpicturesState> mapEventToState(PostpicturesEvent event) async* {
    if (event is PostpicturesFetched) {
      yield await _mapPostFetchedToState(state);
    }
  }

  Future<PostpicturesState> _mapPostFetchedToState(
      PostpicturesState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state is PostpicturesInitial) {
        final movies = await _fetchMoviesOfAPage(page: 1);
        return PostpicturesSuccess(
            // TODO: Break point here
            movies: movies,
            hasReachedMax: false,
            page: 1);
      }
      int newPage = state.page + 1;
      final movies = await _fetchMoviesOfAPage(page: newPage);
      return movies.isEmpty
          ? PostpicturesSuccess(
              movies: List.of(state.movies)..addAll(movies),
              hasReachedMax: true,
              page: newPage)
          : PostpicturesSuccess(
              movies: List.of(state.movies)..addAll(movies),
              hasReachedMax: false,
              page: newPage);
    } on Exception {
      return PostpicturesFailure(
          movies: state.movies,
          hasReachedMax: state.hasReachedMax,
          page: state.page);
    }
  }

  Future<List<Movie>> _fetchMoviesOfAPage({int page}) async {
    // int limit = 20, fixed by themoviedb API
    final response = await httpClient.get(
      "http://api.themoviedb.org/3/movie/popular?page=$page&api_key=$apiKey",
    );
    if (response.statusCode == 200) {
      // TODO: Check this step
      final data = json.decode(response.body)["results"] as List;
      List<Movie> movies = <Movie>[];
      for (int i = 0; i < data.length; i++) {
        Movie movie = await Movie.loadImage(Movie.fromJson(data[i]));
        movies.add(movie);
      }
      return movies;
    }
    throw Exception('Error fetching posts');
  }
}
