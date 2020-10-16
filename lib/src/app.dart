import 'package:bloc_pattern/bloc/postPictures/postpictures_bloc.dart';
import 'package:bloc_pattern/ui/sceens/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class App extends MaterialApp {
  App()
      : super(
          home: Scaffold(
            appBar: AppBar(title: const Text('Popular movies')),
            body: BlocProvider(
              create: (_) => PostpicturesBloc(httpClient: http.Client())
                ..add(PostpicturesFetched()),
              child: PostsList(),
            ),
          ),
        );
}
