class Movies {
  int page;
  int totalResults;
  int totalPages;
  List<Movie> results = [];

  Movies.fromJson(Map<String, dynamic> json) {
    print(json['results'].length);
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    results = [];
    for (int i = 0; i < json['results'].length; i++) {
      results.add(Movie.fromJson(json['results'][i]));
    }
  }
}

class Movie {
  int voteCount;
  int id;
  bool video;
  var voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds = [];
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Movie.fromJson(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'];
    title = json['title'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    for (int i = 0; i < json['genre_ids'].length; i++) {
      genreIds.add(json['genre_ids'][i]);
    }
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }
}
