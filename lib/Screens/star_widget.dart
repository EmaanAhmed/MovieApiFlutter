import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarWidget extends StatefulWidget {

  @override
  _MyStarWidgetState createState() {
    return _MyStarWidgetState();
  }
}

class _MyStarWidgetState extends State<StarWidget> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: AnimatedContainer(
        width: selected ? 40 : 30,
        height: selected ? 40 : 30,
        curve: Curves.fastOutSlowIn,
        duration: Duration(seconds: 1),
        child: Icon(
          Icons.star,
          color: selected ? Colors.yellow : Colors.blueGrey,
          size: selected ? 40 : 30,
        ),
      ),
    );
  }
}
