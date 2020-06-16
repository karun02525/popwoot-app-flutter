import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:popwoot/constraints/constraints.dart';
import 'package:popwoot/ui/model/HomeModel.dart';
import 'package:popwoot/ui/navigation/drawer_navigation.dart';
import 'package:popwoot/ui/widgets/global.dart';
import 'package:popwoot/ui/widgets/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/theme.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List items;
  Dio dio;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    dio = Dio();
    getHomeApiAsync();
  }

  void getHomeApiAsync() async {
    try {
      final response = await dio.get(Constraints.getHomeUrl);
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));

    return Scaffold(
        appBar: AppBar(
          titleSpacing: 2.0,
          title: Text(
            "PopWoot",
            style: TextStyle(
              letterSpacing: 1.0,
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              fontFamily: font,
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {},
              child: SizedBox(
                width: 25.0,
                child: Icon(Icons.search),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications),
            )
          ],
        ),
        drawer: NavigationDrawer(),
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
         getBgImage(Constraints.baseImageUrl+items[index]['ipath']),
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
      margin: EdgeInsets.only(left:10.0,top: 5),
      child: Row(
        children: <Widget>[
         items[index]['userimg'] !=null ? getProfileImage(items[index]['userimg']) :
        CircleAvatar(child: Text(items[index]['user'][0]),),
         setContent(items[index]['user'],items[index]['pname'],items[index]['rdate'])
        ],
      ),
    );
  }

  Widget setContent(String name,String pname,String rdate) {
    return Container(
      margin: EdgeInsets.only(left:10.0,top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextWidget(title: name.toString().toUpperCase(),fontSize: 13.0,),
              TextWidget(title: '  reviewed   ',fontSize:12.0 ,),
              TextWidget(title: '@$rdate',fontSize: 12.0,)
            ],
          ),
          TextWidget(title:pname,isBold: true,),
        ],
      ),
    );
  }

  Widget getProfileImage(String profileUrl) {
    return Container(
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
          itemSize: 25.0, onRatingUpdate: (double rating) {  },
        ));
  }

  Widget descMess(String pdesc) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child:  TextWidget(title:pdesc,fontSize:14.0),);
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
