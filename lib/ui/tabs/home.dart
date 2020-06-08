import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:popwoot/ui/model/HomeModel.dart';
import 'package:popwoot/ui/navigation/drawer_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<HomeModel> items = fetchAllProduct();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light
    ));


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
        body: Container(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) =>
                  buildProductCard(context, index)),
        ));
  }

  Widget buildProductCard(BuildContext context, int index) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getHeadTitle(items, index),
          getBgImage(items[index].bg_url),
          setStar(),
          descMess(),
          bottomView(),
          Container(
            height: 10,
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }

  Widget getHeadTitle(List<HomeModel> items, index) {
    return Container(
      child: Row(
        children: <Widget>[
          getProfileImage(items[index].profile_url),
          setContent(items[index].name)
        ],
      ),
    );
  }

  Widget setContent(String name) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(name,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w100,
                      fontFamily: font,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 5.0),
                child: Text("reviewed",
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w100,
                      fontFamily: font,
                    )),
              ),
              Text(
                "@ 24 MAy 2020 13:10PM",
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w100,
                  fontFamily: font,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 1.0),
            child: Text("Water pump",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: font,
                )),
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

  Widget setStar() {
    return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
        child: FlutterRatingBar(
          initialRating: 4,
          fillColor: Colors.amber,
          borderColor: Colors.amber.withAlpha(50),
          tapOnlyMode: true,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemSize: 25.0,
        ));
  }

  Widget descMess() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: Text(
          "A product is an object or system made available fo offered to a market to satisfy the desire or need of a ...",
          style: TextStyle(
            fontWeight: FontWeight.w100,
            fontFamily: font,
          )),
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
