import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 10,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            'https://via.placeholder.com/600/170b0e',
            fit: BoxFit.cover,
          );
        });
  }
}

/* class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return StreamBuilder(
      stream: bloc.allMovies,
      builder: (context, AsyncSnapshot<Movies> snapshot) {
        if (snapshot.hasData) {
          return buildList(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildList(AsyncSnapshot<Movies> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}',
            fit: BoxFit.cover,
          );
        });
  }
} */
