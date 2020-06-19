import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/ui/product/add_review.dart';
import 'package:popwoot/src/main/ui/product/review_details.dart';
import 'package:popwoot/src/main/ui/widgets/rating_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/res/app_icons.dart';

import 'add_review_widget.dart';
import 'image_load_widget.dart';

class HomeLikeCmt extends StatelessWidget {
  final item;
  HomeLikeCmt({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(AppIcons.ic_mic, size: 20.0,),
          Icon(AppIcons.ic_youtube, size: 20.0,),
          FlatButton.icon(
            onPressed: () {},
            splashColor: Colors.cyanAccent,
            icon: Icon(Icons.favorite_border, size: 20.0, color: Colors.grey[600]),
            label:TextWidget(title: "1 Like", color: Colors.grey[600], fontSize: 12.0)),
          FlatButton.icon(
            onPressed: () {},
            splashColor: Colors.cyanAccent,
            icon: Icon(AppIcons.ic_comment, size: 20.0, color: Colors.grey[600]),
            label:TextWidget(title: "0 comments", color: Colors.grey[600], fontSize: 12.0)
          ),
          AddReviewWidget(data:item)
        ],
      ),
    );
  }
}

