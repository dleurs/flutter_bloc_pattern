class Movies {
  List<_Movie> _listMovies = [];

  Movies() {
    _listMovies = [];
  }

  Movies.fromJson(Map<String, dynamic> parsedJson) {
    //print("JSON to ItemModel");
    //print(parsedJson['results'].length);
    List<_Movie> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      print("Movie : ${parsedJson['results'][i]['title']}");
      _Movie movie = _Movie(parsedJson['results'][i]);
      temp.add(movie);
    }
    _listMovies = temp;
  }

  add(Movies moviesTwo) {
    for (int i = 0; i < moviesTwo._listMovies.length; i++) {
      _listMovies.add(moviesTwo._listMovies[i]);
    }
  }

  List<_Movie> get results => _listMovies;
}

class _Movie {
  String _title;
  String _posterPath;

  _Movie(result) {
    _title = result['title'];
    _posterPath = result['poster_path'];
  }

  String get title => _title;
  String get posterPath => _posterPath;
}
