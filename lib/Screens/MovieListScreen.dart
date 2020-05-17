import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/Models/Movie.dart';
import 'package:myfirstapp/Models/genre.dart';
import 'package:myfirstapp/Provider/movie_provider.dart';
import 'package:myfirstapp/Screens/FavouritsScreen.dart';
import 'package:myfirstapp/Screens/movie_detail.dart';
import 'package:myfirstapp/blocs/movie_bloc.dart';
import 'package:provider/provider.dart';
import 'GenreTileWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieListScreen extends StatefulWidget {
  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieListScreen> {
  List<String> _saved = List<String>();
  List<Genre> genres = List<Genre>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MovieProvider>(context, listen: false).getMovies();
    getFavorites().then((result) {
      if (result != null) {
        _saved = result;
      }
    });
    MovieBloc().getGenresFromRepo().then((result) {
      genres = result;
    });
  }

  @override
  Widget build(BuildContext context) {
//    final WordPair wordPair = WordPair.random();
//    return Text(wordPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies From Api'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildMovies(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return FavouritesScreen();
        },
      ),
    );
  }

  Widget _buildMovies() {
    return Consumer<MovieProvider>(
      builder: (context, MovieProvider movies, Widget child) {
        if (movies.movies.length > 0) {
          return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: movies.movies.length * 2 - 1,
              itemBuilder: (BuildContext _context, int i) {
                if (i.isOdd) {
                  return Divider();
                }
                final int index = i ~/ 2;
                return _buildRow(movies.movies[index]);
              });
        } else {
          return Center(
            child: Text(
              'Loading ...',
              style: _biggerFont,
            ),
          );
        }
      },
    );
  }

  Widget _buildRow(Movie movie) {
    final bool alreadySaved = _saved.contains(movie.title);
    List<String> genreNames = List<String>.from(
        movie.genre.map((jsonEntry) => getGenreName(jsonEntry)));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
//      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return ChangeNotifierProvider<MovieProvider>(
                        create: (context) => MovieProvider(),
                        child: MovieDetails(movie.id),
                      );
                      MovieDetails(movie.id);
                    },
                  ),
                );
              },
              child: Hero(
                tag: 'imageHero' + movie.id.toString(),
                child: Image(
                  image: NetworkImage(
                      "https://image.tmdb.org/t/p/w185/${movie.image}"),
                  height: MediaQuery.of(context).size.height * .20,
                  width: MediaQuery.of(context).size.width * .30,
                ),
              ),
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width * .60,
          child: Column(
//            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListTile(
                title: Text(
                  movie.title,
                  style: _biggerFont,
                ),
                subtitle: Text(
                  'releaseYear : ${movie.releaseYear}',
                ),
                trailing: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (alreadySaved) {
                          _saved.remove(movie.title);
                        } else {
                          _saved.add(movie.title);
                        }
                        saveFavorite();
                      });
                    },
                    child: Icon(
                      alreadySaved ? Icons.favorite : Icons.favorite_border,
                      color: alreadySaved ? Colors.red : null,
                    )),
//                onTap: () {
//                  setState(() {
//                    if (alreadySaved) {
//                      _saved.remove(movie.title);
//                    } else {
//                      _saved.add(movie.title);
//                    }
//                    saveFavorite();
//                  });
//                },
              ),
//        Row(
//
//          children:[
//            ...movie.genre.map((genreId) => GenreTile(getGenreName(genreId))).toList(),
              SizedBox(
                height: 40,
                child: GenreTile(genreNames),
              ),
            ],
          ),
        ),
      ],
    );
//      ],
//    );
  }

  String getGenreName(int id) {
    Genre g = genres.firstWhere((item) => item.id == id);
    return g.name;
  }

  saveFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _saved);
  }

  Future<List<String>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("favorites");
  }
}
