import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/Models/genre.dart';
import 'package:myfirstapp/blocs/movie_bloc.dart';

// ignore: must_be_immutable
class GenreTile extends StatelessWidget {
  List<String> genreNames;
  GenreTile(this.genreNames);

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 3.0,
        color: Colors.black12,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(20.0) //         <--- border radius here
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: genreNames.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext _context, int i) {
          return BuildGenre(genreNames[i]);
        });
  }

  // ignore: non_constant_identifier_names
  Widget BuildGenre(String name) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 1, 0),
      padding: const EdgeInsets.all(10.0),
      decoration: myBoxDecoration(), //       <--- BoxDecoration here
      child: Text(
        name,
        style: TextStyle(fontSize: 12.0),
      ),
    );
  }
}

//  Container(
//  margin: const EdgeInsets.all(10.0),
//  padding: const EdgeInsets.all(10.0),
//  decoration: myBoxDecoration(), //       <--- BoxDecoration here
//  child: Text(
//  genreNames[i],
//  style: TextStyle(fontSize: 12.0),
//  ),
//  );
