
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/home_reviews_model.dart';
import 'package:popwoot/src/main/ui/product/review_details.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';

class ReviewHeaderWidget extends StatelessWidget {
  dynamic item;
  BuildContext context;
  ReviewHeaderWidget({this.item});

  @override
  Widget build(BuildContext context) {
    this.context=context;
    return getHeadTitle();
  }

  Widget getHeadTitle() {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          ImageLoadWidget(imageUrl:item.userimg,name:item.username??'P',isProfile: true),
          setContent()
        ],
      ),
    );
  }

  Widget setContent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextWidget(
                title:item.username??'',
                fontSize: 13.0,
              ),
              TextWidget(
                title: '  reviewed   ',
                fontSize: 12.0,
              ),
              TextWidget(
                title: '@${item.rdate??'----'}',
                fontSize: 12.0,
              )
            ],
          ),
          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ReviewDetails(pid:item.pid,pname:item.pname)));
              },
              child: TextWidget(
                title: item.pname??'N.A',
                isBold: true,
              ))
        ],
      ),
    );
  }
}
