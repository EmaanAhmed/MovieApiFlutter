import 'package:myfirstapp/API/movies_api.dart';
import 'package:myfirstapp/Models/Movie.dart';
import 'package:myfirstapp/Models/genre.dart';

class MovieRepository
{
  Future<List<Movie>> getMovies() async{
    return await MoviesApi().fetchMoviesOnline();
  }
  Future<List<Genre>> getGenres() async{
    return await MoviesApi().getMovieGenere();
  }
  Future<Movie> getMovieDetails(int id) async{
    return await MoviesApi().getMovieDetails(id);
  }
}