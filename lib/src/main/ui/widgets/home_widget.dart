import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/ui/product/add_review.dart';
import 'package:popwoot/src/main/ui/product/review_details.dart';
import 'package:popwoot/src/main/ui/widgets/rating_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/res/app_icons.dart';

import 'add_review_widget.dart';
import 'home_like_widget.dart';
import 'image_load_widget.dart';

class HomeWidget extends StatelessWidget {
  final List items;
  final int index;
  HomeWidget({this.items,this.index,});

  @override
  Widget build(BuildContext context) {
    var item = items[index];
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getHeadTitle(context,item),
          ImageLoadWidget(imageUrl:item['ipath']),
          RatingWidget(rating: item['astar']),
          descMess(item['pdesc']),
          HomeLikeCmt(item: item),
          Container(height: 10, color: Colors.grey[200]),
        ],
      ),
    );
  }

  Widget getHeadTitle(context,item) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 5),
      child: Row(
        children: <Widget>[
          ImageLoadWidget(imageUrl:item['userimg'],name:item['user'],isProfile: true),
          setContent(context,item['pid'], item['user'], item['pname'], item['rdate'])
        ],
      ),
    );
  }

  Widget setContent(context,String pid, String name, String pname, String rdate) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 5),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
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


  Widget getBgImage(String bgUrl) {
    return Container(
        width: double.infinity,
        height: 200.0,
        margin: EdgeInsets.only(top: 8.0),
        child: ImageLoadWidget(imageUrl: bgUrl));
  }

  Widget descMess(String pdesc) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: TextWidget(title: pdesc, fontSize: 14.0),
    );
  }

  Widget bottomView(item) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.mic_none),
          FlatButton.icon(
            onPressed: () {},
            splashColor: Colors.cyanAccent,
            icon: Icon(Icons.favorite_border, color: Colors.grey[600]),
            label: Text(
              "1 Like",
              style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
            ),
          ),
          FlatButton.icon(
            onPressed: () {},
            splashColor: Colors.cyanAccent,
            icon: Icon(Icons.chat_bubble_outline, color: Colors.grey[600]),
            label: Text(
              "0 comments",
              style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
            ),
          ),
          AddReviewWidget(data: [item['pid'], item['pname'], item['pdesc'], item['ipath']])
        ],
      ),
    );
  }
}
