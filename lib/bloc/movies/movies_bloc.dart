import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial());

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
