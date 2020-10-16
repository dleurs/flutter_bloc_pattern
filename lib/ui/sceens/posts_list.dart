import 'package:bloc_pattern/bloc/postPictures/postpictures_bloc.dart';
import 'package:bloc_pattern/ui/components/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();
  PostpicturesBloc _postpicturesBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postpicturesBloc = context.bloc<PostpicturesBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostpicturesBloc, PostpicturesState>(
      listener: (context, state) {
        if (!state.hasReachedMax && _isBottom) {
          _postpicturesBloc.add(PostpicturesFetched());
        }
      },
      builder: (context, state) {
        if (state is PostpicturesFailure) {
          return const Center(child: Text('failed to fetch posts'));
        } else if (state is PostpicturesSuccess) {
          if (state.movies.isEmpty) {
            return const Center(child: Text('no posts'));
          }
          return GridView.builder(
            itemCount: state.hasReachedMax
                ? state.movies.length + 1
                : state.movies.length + 2,
            controller: _scrollController,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return index >= state.movies.length
                  ? BottomLoader()
                  : //Image.network(
                  //  'https://image.tmdb.org/t/p/w185${state.movies[index].posterPath}',
                  Image.memory(
                      state.movies[index].image,
                      fit: BoxFit.cover,
                    );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _postpicturesBloc.add(PostpicturesFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final double height = MediaQuery.of(context).size.height;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
