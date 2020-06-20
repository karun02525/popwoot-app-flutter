import 'dart:convert';
import 'dart:developer';
import 'dart:io' show Platform;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/app_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_review_widget.dart';
import 'icon_widget.dart';

class HomeLikeCmt extends StatefulWidget {
  final item;

  HomeLikeCmt({Key key, this.item}) : super(key: key);

  @override
  _HomeLikeCmtState createState() => _HomeLikeCmtState(item);
}

class _HomeLikeCmtState extends State<HomeLikeCmt> {
  dynamic item;
  _HomeLikeCmtState(this.item);

  dynamic likeData;
  Dio dio;
  bool isLike = false;
  int likeCount = 0;
  String likeMsg = "Like";
  String rid = '';
  bool _isYoutube = false;
  String youtubeLink = '';

  @override
  void initState() {
    super.initState();
    dio = Dio();
    rid = item['id'];
    likeCount = item['nlike'] == null ? 0 : item['nlike'];
    youtubeLink = item['youtubeurl'] == null ? '' : item['youtubeurl'];

    if (youtubeLink.toString().contains('https://youtu')) {
      _isYoutube = true;
    } else
      _isYoutube = false;
  }

  void doLikeApiAsync() async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization': 'Bearer ${Config.token}'
      };

      debugPrint('print api object : ${Config.doReviewLikeUrl}/$rid ');
      debugPrint(
          'print api object authorization :' + requestHeaders.toString());

      final response = await dio.get('${Config.doReviewLikeUrl}/$rid',
          options: Options(headers: requestHeaders));

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        debugPrint('print Review Like :' + responseBody.toString());
        if (responseBody['status']) {
          // doLikeOrDlike(true);
          setState(() {
            likeData = responseBody['data'];
          });
        }
      }
    } on DioError catch (e) {
      var errorMessage = jsonDecode(jsonEncode(e.response.data));
      var statusCode = e.response.statusCode;

      if (statusCode == 400) {
        doLikeOrDlike(false);
        Global.toast(errorMessage['message']);
      } else if (statusCode == 401) {
        doLikeOrDlike(false);
        Global.toast(errorMessage['message']);
      } else {
        doLikeOrDlike(false);
        Global.toast('Something went wrong');
      }
    }
  }

  void doLikeToggle() {
    doLikeApiAsync();
    setState(() {
      if (isLike == false) {
        doLikeOrDlike(true);
        isLike = true;
      } else {
        doLikeOrDlike(false);
        isLike = false;
      }
    });
  }

  void doLikeOrDlike(bool flag) {
    setState(() {
      if (flag) {
        likeCount++;
        likeMsg = 'Like';
      } else {
        likeCount--;
        likeMsg = 'Unlike';
      }
    });
  }

  _launchURL() async {
    if (Platform.isIOS) {
      if (await canLaunch(youtubeLink)) {
        await launch(youtubeLink, forceSafariVC: false);
      } else {
        if (await canLaunch(youtubeLink)) {
          await launch(youtubeLink);
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
        }
      }
    } else {
      if (await canLaunch(youtubeLink)) {
        await launch(youtubeLink);
      } else {
        throw 'Could not launch $youtubeLink';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(AppIcons.ic_mic, size: 20.0),
          Visibility(
              child: InkWell(
                 splashColor: Colors.cyanAccent,
                  onTap: () {
                    _launchURL();
                  },
                  child: AppIcons.ic_youtube),
              visible: _isYoutube),
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
          AddReviewWidget(data: item),
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
