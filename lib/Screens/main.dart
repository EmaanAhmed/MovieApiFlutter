import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/Provider/movie_provider.dart';
import 'package:provider/provider.dart';
import 'MovieListScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primaryColor: Colors.red[200],
        backgroundColor: Colors.white,
      ),
      home: ChangeNotifierProvider<MovieProvider>(
        create: (context) => MovieProvider(),
        child: MovieListScreen(),
      ),
    );
  }
}
