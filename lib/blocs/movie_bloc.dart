import 'package:myfirstapp/Models/Movie.dart';
import 'package:myfirstapp/Models/genre.dart';
import 'package:myfirstapp/MovieRepositry/movie_repository.dart';

class MovieBloc
{

  Future<List<Genre>> getGenresFromRepo () async
  {
    return await MovieRepository().getGenres();
  }

}