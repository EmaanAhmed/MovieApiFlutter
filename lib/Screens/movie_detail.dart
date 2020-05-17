import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/Models/genre.dart';
import 'package:myfirstapp/Provider/movie_provider.dart';
import 'package:myfirstapp/Screens/star_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MovieDetails extends StatefulWidget {
  int id;

  MovieDetails(this.id);

  @override
  DetailsScreen createState() {
    // TODO: implement createState
    return DetailsScreen(id);
  }
}

class DetailsScreen extends State<MovieDetails> {
  int id;

  DetailsScreen(this.id);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MovieProvider>(context, listen: false).getMovieDetails(id);
  }

  @override
  Widget build(BuildContext context) {
    var concatenate = StringBuffer();
    return Consumer<MovieProvider>(
      builder: (context, MovieProvider movies, Widget child) {
        if (movies.movieDetails != null) {
          var movie = movies.movieDetails;
          movie.genres.forEach((item) {
            Genre g = Genre.fromJson(item);
            concatenate
                .write(String.fromCharCode(0x2022) + " " + g.name + "  ");
          });
          return Material(
            type: MaterialType.transparency,
            child: Container(
              color: Colors.red[200],
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Hero(
                            tag: 'imageHero' + movie.id.toString(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500/${movie.image}'),
                              ),
                            ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: Text(
                                movie.title,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            movie.rating.toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 2, 16, 2),
                      child: Text(
                        concatenate.toString(),
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                          child: Text(
                            'Description',
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: StarWidget(),
                        )
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: Text(
                            movie.overview,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Text('');
        }
      },
    );

  }
}
