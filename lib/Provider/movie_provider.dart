
import 'package:flutter/foundation.dart';
import 'package:myfirstapp/Models/Movie.dart';
import 'package:myfirstapp/Models/genre.dart';
import 'package:myfirstapp/MovieRepositry/movie_repository.dart';

class MovieProvider with ChangeNotifier
{
  List<Movie> movies= List<Movie>();
  List<Genre> genres = List<Genre>();
  Movie movieDetails;

  void getMovies() async
  {
    movies = await MovieRepository().getMovies();
    notifyListeners();
  }
  void getGenres () async
  {
    genres = await MovieRepository().getGenres();
    notifyListeners();
  }
  void getMovieDetails (int id) async
  {
    movieDetails = await MovieRepository().getMovieDetails(id);
    notifyListeners();
  }
}