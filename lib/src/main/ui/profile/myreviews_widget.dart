import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popwoot/src/main/api/model/home_reviews_model.dart';
import 'package:popwoot/src/main/ui/widgets/home_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';

class MyReviews extends StatefulWidget {
  final List<RevieswModel> reviewswList;
  MyReviews({this.reviewswList});

  @override
  _MyReviewsState createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));

    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: widget.reviewswList == null
    ? Container(child: Center(child: TextWidget(title: 'Empty My Reviews')))
          : ListView.builder(
          itemCount: widget.reviewswList.length,
          itemBuilder: (context, index) =>
              HomeWidget(items: widget.reviewswList, index: index)),
    );
  }
}
