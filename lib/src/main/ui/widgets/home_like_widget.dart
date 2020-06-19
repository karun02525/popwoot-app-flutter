import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/app_icons.dart';

import 'add_review_widget.dart';
import 'icon_widget.dart';
class HomeLikeCmt extends StatefulWidget {
  final item;

  HomeLikeCmt({this.item});

  @override
  _HomeLikeCmtState createState() => _HomeLikeCmtState();
}

class _HomeLikeCmtState extends State<HomeLikeCmt> {
  dynamic likeData;
  Dio dio;
  bool isLike = false;
  int likeCount = 0;
  String likeMsg = "Like";
  String rid="";

  @override
  void initState() {
    super.initState();
    dio = Dio();
  }

  void doLikeApiAsync() async {
    try {

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization': 'Bearer ${Config.token}'
      };

      debugPrint('print api object : ${Config.doReviewLikeUrl}/$rid ');
      debugPrint('print api object authorization :'+requestHeaders.toString());

      final response = await dio.get('${Config.doReviewLikeUrl}/$rid',
          options: Options(headers: requestHeaders));



      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        debugPrint('print Review Like :' + responseBody.toString());
        if (responseBody['status']) {
          setState(() {
            likeData = responseBody['data'];
          });
        }
      }
    } on DioError catch (e) {
      var errorMessage = jsonDecode(jsonEncode(e.response.data));
      var statusCode = e.response.statusCode;

      if (statusCode == 400) {
        Global.toast(errorMessage['message']);
      } else if (statusCode == 401) {
        Global.toast(errorMessage['message']);
      } else {
        Global.toast('Something went wrong');
      }
    }
  }

  void doLikeToggle() {
    doLikeApiAsync();
    setState(() {
      if (isLike == false) {
        likeCount++;
        likeMsg = 'Like';
        isLike = true;
      } else {
        likeCount--;
        likeMsg = 'Unlike';
        isLike = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    rid=widget.item['id'];

    return Container(
      margin: EdgeInsets.only(top: 8.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(AppIcons.ic_mic, size: 20.0),
          AppIcons.ic_youtube,
          IconWidget(
              icon: isLike ? Icons.favorite : Icons.favorite_border,
              mgs: '$likeMsg ${likeCount.toString()}',
              onTap: () {
                doLikeToggle();
              }),
          IconWidget(
            icon: AppIcons.ic_comment,
            mgs: 'Comment 12',
            onTap: () {},
          ),
          AddReviewWidget(data: widget.item),
        ],
      ),
    );
  }
}
/*


Expanded(
flex: 5,
child: FlatButton.icon(
padding: EdgeInsets.all(0),
color: Colors.green,
onPressed: () {},
splashColor: Colors.cyanAccent,
icon: Icon(AppIcons.ic_comment,
size: 20.0, color: Colors.grey[600]),
label: TextWidget(
title: "0 comments",
color: Colors.grey[600],
fontSize: 12.0))),
Expanded(flex: 5, child: AddReviewWidget(data: item))

*/
