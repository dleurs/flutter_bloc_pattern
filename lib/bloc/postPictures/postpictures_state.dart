part of 'postpictures_bloc.dart';

abstract class PostpicturesState extends Equatable {
  final List<Movie> movies;
  final int page;
  final bool hasReachedMax;

  const PostpicturesState(
      {this.movies = const <Movie>[],
      this.hasReachedMax = false,
      this.page = 1});

  @override
  List<Object> get props => [movies, hasReachedMax];
}

class PostpicturesInitial extends PostpicturesState {}

class PostpicturesSuccess extends PostpicturesState {
  PostpicturesSuccess({List<Movie> movies, bool hasReachedMax, int page})
      : super(movies: movies, hasReachedMax: hasReachedMax, page: page);
}

class PostpicturesFailure extends PostpicturesState {
  PostpicturesFailure({List<Movie> movies, bool hasReachedMax, int page})
      : super(movies: movies, hasReachedMax: hasReachedMax, page: page);
}
