import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingWidget extends StatelessWidget {
  final String rating;
  double value;
  final Function onPressed;
  final bool isDisable;

  RatingWidget({this.rating, this.value, this.onPressed, this.isDisable = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: FlutterRatingBar(
        initialRating: double.parse(rating==null?"0":rating),
        fillColor: Colors.amber,
        borderColor: Colors.yellow[600],
        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
        itemSize: 20.0,
        ignoreGestures: !isDisable,
        onRatingUpdate: (double rating) {
          value= rating;
        },
      ),
    );
  }
}
