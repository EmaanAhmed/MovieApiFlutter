import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class FavouritesScreen extends StatelessWidget {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  FavouritesScreen() {
    getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies From Api'),
      ),
      body: _buildFavorites(),
    );
//    final Iterable<ListTile> tiles = favorites.map(
//      (String movieTitle) {
//        return ListTile(
//          title: Text(
//            movieTitle,
//            style: _biggerFont,
//          ),
//        );
//      },
//    );
//    final List<Widget> divided = ListTile.divideTiles(
//      context: context,
//      tiles: tiles,
//    ).toList();
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Saved Movies'),
//      ),
//      body: ListView(
//        children: divided,
//      ),
//    );
  }
  Widget _buildFavorites()
  {
    return FutureBuilder<List<String>>(
      future: getFavorites(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
          return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data.length * 2 ,
              itemBuilder: (BuildContext _context, int i) {
                if (i.isOdd) {
                  return Divider();
                }
                final int index = i ~/ 2;
                return _buildRow(snapshot.data[index]);
              });
        } else {
          return Center(
            child: Text(
              'Nothing Added Yet, Add some ;)',
              style: _biggerFont,
            ),
          );
        }
      },
    );
  }

  Widget _buildRow(String movieTitle) {
    return
        ListTile(
          title: Text(
            movieTitle,
            style: _biggerFont,
          ),
    );
  }

  Future <List<String>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("favorites");

  }
}
