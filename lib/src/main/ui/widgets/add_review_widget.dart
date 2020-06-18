import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/ui/product/add_review.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';

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
        icon: Icon(
          Icons.open_in_new,
          size: 20.0,
        ),
        label: TextWidget(
          title: "Add Review",
          color: Colors.grey[400],
          fontSize: 14.0,
        ));
  }
}
