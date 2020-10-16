import 'package:bloc_pattern/bloc/postPictures/postpictures_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/posts/posts.dart';

class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();
  PostpicturesBloc _PostpicturesBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _PostpicturesBloc = context.bloc<PostpicturesBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostpicturesBloc, PostpicturesState>(
      listener: (context, state) {
        if (!state.hasReachedMax && _isBottom) {
          _PostpicturesBloc.add(PostpicturesFetched());
        }
      },
      builder: (context, state) {
        if (state is PostpicturesFailure) {
return const Center(child: Text('failed to fetch posts'));
        }
            
          case PostStatus.success:
            if (state.posts.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.posts.length
                    ? BottomLoader()
                    : PostListItem(post: state.posts[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.posts.length
                  : state.posts.length + 1,
              controller: _scrollController,
            );
          default:
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
    if (_isBottom) _PostpicturesBloc.add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
