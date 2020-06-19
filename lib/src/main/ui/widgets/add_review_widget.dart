import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/ui/product/add_review.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/res/app_icons.dart';

class AddReviewWidget extends StatelessWidget {
  final data;
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
                      arguments: [data['pid'],data['pname'],data['pdesc'],data['ipath']])));
        },
        splashColor: Colors.cyanAccent,
        icon: Icon(AppIcons.ic_add_review, size: 20.0, color: Colors.grey[600]),
        label: TextWidget(
          title: "Add Review",
          color: Colors.grey[600],
          fontSize: 12.0,
        ));
  }
}
