import 'dart:async';
import 'dart:convert';
import '../models/item_model.dart';
import 'package:http/http.dart' show Client;

class MoviesBloc {
  Client _httpClient = Client();
  Movies _movies;
  
  // Change the api Key to yours via https://www.themoviedb.org
  final _apiKey = 'PUT_YOUR_KEY_HERE';

  final _moviesStreamController = StreamController<Movies>();

  Stream<Movies> get moviesStream => _moviesStreamController.stream;
  StreamSink<Movies> get moviesSink => _moviesStreamController.sink;

  MoviesBloc() {
    initData();
  }

  initData() async {
    _movies = await loadMovies();
    _moviesStreamController.sink.add(_movies);
  }

  Future<Movies> loadMovies() async {
    final response = await _httpClient
        .get("http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");
    //print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return Movies.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  dispose() {
    _moviesStreamController.close();
  }

  vote(Movie movie, int vote) {
    var item = _movies.results.where((m) => m.id == movie.id).first;
    item.voteCount += vote;
    _moviesStreamController.sink.add(_movies);
  }

}

