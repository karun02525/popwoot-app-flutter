import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/home_reviews_model.dart';
import 'package:popwoot/src/main/ui/product/add_review.dart';
import 'package:popwoot/src/main/ui/product/review_details.dart';
import 'package:popwoot/src/main/ui/widgets/rating_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/res/app_icons.dart';

import 'add_review_widget.dart';
import 'home_like_widget.dart';
import 'image_load_widget.dart';

class HomeWidget extends StatelessWidget {
  ReviewsModel item;
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
          getHeadTitle(),
          ImageLoadWidget(imageUrl:item.imgarray[0]),
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
          RatingWidget(rating: item.astar??'0'),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: TextWidget(title: item.rdname??'---', fontSize: 14.0),
          ),
          Divider(),
          HomeLikeCmt(item: item),
        ],
      ),
    );
  }


  Widget getHeadTitle() {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          ImageLoadWidget(imageUrl:item.userimg,name:item.user??'P',isProfile: true),
          setContent(item.pid??'0', item.user??'', item.pname??'', item.rdate??'---')
        ],
      ),
    );
  }

  Widget setContent(String pid, String name, String pname, String rdate) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextWidget(
                title: name.toString().toUpperCase(),
                fontSize: 13.0,
              ),
              TextWidget(
                title: '  reviewed   ',
                fontSize: 12.0,
              ),
              TextWidget(
                title: '@$rdate',
                fontSize: 12.0,
              )
            ],
          ),
          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ReviewDetails(),
                        settings: RouteSettings(arguments: [pname, pid])));
              },
              child: TextWidget(
                title: pname,
                isBold: true,
              ))
        ],
      ),
    );
  }
}
