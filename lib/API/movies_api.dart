import 'dart:convert';

import 'package:myfirstapp/HttpClient/network_client.dart';
import 'package:myfirstapp/Models/Movie.dart';
import 'package:myfirstapp/Models/genre.dart';

class MoviesApi
{
   Future<List<Movie>> fetchMoviesOnline() async {
    var jsonResponse =
//    await HttpClient().fetchData('https://api.androidhive.info/json/movies.json') as List;
    await HttpClient().fetchData('https://api.themoviedb.org/3/discover/movie?api_key=6557d01ac95a807a036e5e9e325bb3f0&sort_by=popularity.desc') ;
    var results = jsonResponse['results'] as List;
    return List<Movie>.from(
        results.map((jsonEntry) => Movie.fromJson(jsonEntry)));
  }
  
  Future<List<Genre>> getMovieGenere() async {
    var jsonResponse = await HttpClient().fetchData("https://api.themoviedb.org/3/genre/movie/list?api_key=6557d01ac95a807a036e5e9e325bb3f0&language=en-US");
    var results = jsonResponse['genres'] as List;
    return List<Genre>.from(
        results.map((jsonEntry) => Genre.fromJson(jsonEntry)));

  }
  
  Future<Movie> getMovieDetails(int id) async{
     var jsonResponse =
     await HttpClient().fetchData('https://api.themoviedb.org/3/movie/$id?api_key=6557d01ac95a807a036e5e9e325bb3f0&language=en-US') ;
     return Movie.fromJson(jsonResponse);

  }



}


