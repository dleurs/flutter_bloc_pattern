part of 'postpictures_bloc.dart';

abstract class PostpicturesEvent extends Equatable {
  const PostpicturesEvent();

  @override
  List<Object> get props => [];
}

class PostpicturesFetched extends PostpicturesEvent {}
