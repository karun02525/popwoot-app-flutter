import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  double value;
  final Function onRatingUpdate;
  final bool isDisable;

  RatingWidget({this.rating, this.value, this.onRatingUpdate, this.isDisable = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: FlutterRatingBar(
        initialRating: rating,
        fillColor: Colors.black87,
        borderColor: Colors.black54,
        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
        itemSize: 20.0,
        ignoreGestures: !isDisable,
        onRatingUpdate:onRatingUpdate
      ),
    );
  }
}
