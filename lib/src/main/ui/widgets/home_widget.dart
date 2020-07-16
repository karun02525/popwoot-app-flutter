import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/home_reviews_model.dart';
import 'package:popwoot/src/main/ui/product/add_review.dart';
import 'package:popwoot/src/main/ui/product/review_details.dart';
import 'package:popwoot/src/main/ui/widgets/rating_widget.dart';
import 'package:popwoot/src/main/ui/widgets/review_header_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/res/app_icons.dart';

import 'add_review_widget.dart';
import 'home_like_widget.dart';
import 'image_load_widget.dart';
import 'image_slider_widget.dart';

class HomeWidget extends StatelessWidget {
  final ReviewsModel item;
  BuildContext context;
  HomeWidget({this.item});

  @override
  Widget build(BuildContext context) {
    this.context=context;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ReviewHeaderWidget(item:item),
          ImageSliderWidget(imgList:item?.reviewsImgarray??[]),
          paddingView(),
          Container(height: 10, color: Colors.grey[200]),
        ],
      ),
    );
  }

  Widget paddingView(){
    return Container(
      margin: EdgeInsets.only(left:7.0,top: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RatingWidget(rating:item.rating),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: TextWidget(title: item.comment??'---', fontSize: 14.0),
          ),
          Divider(),
          HomeLikeCmt(item: item),
        ],
      ),
    );
  }

}
