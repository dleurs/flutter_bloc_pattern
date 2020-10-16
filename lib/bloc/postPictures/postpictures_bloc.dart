import 'dart:async';
import 'package:bloc_pattern/models/movie.dart';
import 'package:bloc_pattern/src/ui/movie_list.dart';
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
        final movies = await _fetchPosts(page: 1);
        return PostpicturesSuccess(movies: movies, hasReachedMax: false);
      }
      final movies = await _fetchPosts(page: state.page + 1);
      return movies.isEmpty
          ? PostpicturesSuccess(
              movies: List.of(state.movies)..addAll(movies),
              hasReachedMax: false)
          : PostpicturesSuccess(
              movies: List.of(state.movies)..addAll(movies),
              hasReachedMax: false);
    } on Exception {
      return PostpicturesFailure(
          movies: state.movies,
          hasReachedMax: state.hasReachedMax,
          page: state.page);
    }
  }

  Future<List<Movie>> _fetchPosts({int page}) async {
    // int limit = 20, fixed by themoviedb API
    final response = await httpClient.get(
      "http://api.themoviedb.org/3/movie/popular?page=$page&api_key=$apiKey",
    );
    if (response.statusCode == 200) {
      // TODO: Check this step
      final data = json.decode(response.body) as List;
      print("Data json.decode");
      print(data);
      return data.map((dynamic rawPost) {
        print("Raw post");
        print(rawPost);
        return Movie(rawPost);
      }).toList();
    }
    throw Exception('Error fetching posts');
  }
}
