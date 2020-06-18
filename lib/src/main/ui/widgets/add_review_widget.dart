import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/ui/product/add_review.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/res/app_icons.dart';

class AddReviewWidget extends StatelessWidget {
  final  List<String> data;

  AddReviewWidget({this.data});

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddReview(),
                  settings: RouteSettings(
                      arguments: [data[0],data[1],data[2],data[3]])));
        },
        splashColor: Colors.cyanAccent,
        icon: Icon(AppIcons.ic_add_review, size: 20.0, color: Colors.grey[600]),
        label: TextWidget(
          title: "Add Review",
          color: Colors.grey[600],
          fontSize: 14.0,
        ));
  }
}
