import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/fonts.dart';


class ReviewDetails extends StatefulWidget {
  @override
  _ReviewDetailsState createState() => _ReviewDetailsState();
}

class _ReviewDetailsState extends State<ReviewDetails> {
  List items;
  Dio dio;
  bool _isLoading = true;
  String pcode;

  @override
  void initState() {
    super.initState();
    dio = Dio();
    getHomeApiAsync();
  }

  void getHomeApiAsync() async {
    try {
      final response = await dio.get(Config.getHomeUrl);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        if (responseBody['status']) {
          hideLoader();
          setState(() {
            items = responseBody['data'];
          });
        }
      }
    } on DioError catch (e) {
      var errorMessage = jsonDecode(jsonEncode(e.response.data));
      var statusCode = e.response.statusCode;

      debugPrint("print: error :" + errorMessage.toString());
      debugPrint("print: statusCode :" + statusCode.toString());

      if (statusCode == 400) {
        hideLoader();
        Global.toast(errorMessage['message']);
      } else if (statusCode == 401) {
        hideLoader();
        Global.toast(errorMessage['message']);
      } else {
        hideLoader();
        Global.toast('Something went wrong');
      }
    }
  }

  void hideLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    pcode = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          titleSpacing: 2.0,
          leading: BackButton(color: Colors.black),
          title: TextWidget(title: "Review", color: Colors.black,fontSize: AppFonts.toolbarSize, isBold: true)),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) =>
                  buildProductCard(context, index)),
    );
  }

  Widget buildProductCard(BuildContext context, int index) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getHeadTitle(items, index),
          getBgImage(Config.baseImageUrl + items[index]['ipath']),
          setStar(items[index]['astar']),
          descMess(items[index]['pdesc']),
          bottomView(),
          Container(
            height: 10,
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }

  Widget getHeadTitle(List items, index) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 5),
      child: Row(
        children: <Widget>[
          items[index]['userimg'] != null
              ? getProfileImage(items[index]['userimg'])
              : CircleAvatar(
                  child: Text(items[index]['user'][0]),
                ),
          setContent(items[index]['user'], items[index]['pname'],
              items[index]['rdate'])
        ],
      ),
    );
  }

  Widget setContent(String name, String pname, String rdate) {
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
          TextWidget(
            title: pname,
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget getProfileImage(String profileUrl) {
    return Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.only(left: 13, top: 10.0, bottom: 2),
        child: CachedNetworkImage(
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          placeholder: (context, url) => CircularProgressIndicator(),
          imageUrl: profileUrl,
        ));
  }

  Widget getBgImage(String bgUrl) {
    return Container(
      width: double.infinity,
      height: 200.0,
      margin: EdgeInsets.only(top: 8.0),
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: bgUrl,
      ),
    );
  }

  Widget setStar(String astar) {
    return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
        child: FlutterRatingBar(
          initialRating: double.parse(astar),
          fillColor: Colors.amber,
          borderColor: Colors.amber.withAlpha(50),
          tapOnlyMode: true,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemSize: 25.0,
          onRatingUpdate: (double rating) {},
        ));
  }

  Widget descMess(String pdesc) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: TextWidget(title: pdesc, fontSize: 14.0),
    );
  }

  Widget bottomView() {
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
          FlatButton.icon(
            onPressed: () {},
            splashColor: Colors.cyanAccent,
            icon: Icon(Icons.open_in_new, color: Colors.grey[600]),
            label: Text(
              "Add Review",
              style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}
