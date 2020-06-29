import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/widgets/add_review_widget.dart';
import 'package:popwoot/src/main/ui/widgets/home_like_widget.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/rating_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/fonts.dart';

class ReviewDetails extends StatefulWidget {
  @override
  _ReviewDetailsState createState() => _ReviewDetailsState();
}

class _ReviewDetailsState extends State<ReviewDetails> {
  List items = [];
  dynamic productData;
  Dio dio;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    dio = Dio();
  }

  void getProductApiAsync(String pcode) async {
    try {
      final response = await dio.get('${Config.getReviewDetailsUrl}/$pcode');
      debugPrint('print api object : ${Config.getReviewDetailsUrl}/$pcode ');
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        debugPrint('print api object :' + responseBody.toString());
        if (responseBody['status']) {
           getProductReviewApiAsync(pcode);
          productData = responseBody['idata'];
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

  void getProductReviewApiAsync(String pcode) async {
    try {
      final response =
          await dio.get('${Config.getReviewListDetailsUrl}/$pcode/1');
      debugPrint('print api List : ${Config.getReviewListDetailsUrl}/$pcode/1');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        if (responseBody['status']) {
          debugPrint('print api List :' + responseBody.toString());
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
    List data = ModalRoute.of(context).settings.arguments;
    setState(() {
      getProductApiAsync(data[1]);
    });

    return Scaffold(
        appBar: AppBar(
            brightness: Brightness.light,
            titleSpacing: 2.0,
            centerTitle: true,
            title: TextWidget(
                title: "${data[0]}",
                fontSize: AppFonts.toolbarSize,
                isBold: true)),
        body: _isLoading ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView.builder(
                itemCount: items.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return buildHeader(productData);
                  }
                  index -= 1;
                  return buildProductCard(context, index);
                }));
  }

  Widget buildProductCard(BuildContext context, int index) {
    var item=items[index];
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getHeadTitle(item, index),
          paddingView(item),
          Container(height: 3.0, color: Colors.grey[200]),
        ],
      ),
    );
  }

  Widget paddingView(item){
    return Container(
      margin: EdgeInsets.only(left:7.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RatingWidget(rating: item['astar']),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: TextWidget(title: item['pdesc'], fontSize: 14.0),
          ),
          Divider(),
          //HomeLikeCmt(item: item),
        ],
      ),
    );
  }




  Widget getHeadTitle(item, index) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          ImageLoadWidget(imageUrl:item['userimg'],name:item['user'],isProfile: true),
          setContent(item['user'], item['pname'], item['rdate'])
        ],
      ),
    );
  }

  Widget setContent(String name, String pname, String rdate) {
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
                isBold: true,
              ),
              TextWidget(
                title: '  reviewed            ',
                fontSize: 12.0,
              ),
              TextWidget(
                title: '@$rdate',
                fontSize: 10.0,
              )
            ],
          ),
        ],
      ),
    );
  }
  Widget buildHeader(item) {
    return Container(
      color: Colors.white,
      child: Column(
         children: <Widget>[
          ImageLoadWidget(imageUrl:productData['ipath']),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:5.0,top: 5.0),
                child: RatingWidget(rating:item['astar']),
              ),
              Padding(
                padding: const EdgeInsets.only(right:10.0,top: 5.0),
                child: AddReviewWidget(data:item),
              )
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(padding: EdgeInsets.only(left: 10.0,bottom: 10.0),
              child: TextWidget(
                  title: productData['pdesc'] == null ? "" : productData['pdesc']),
            ),
          ),
          Container(height: 10.0, color: Colors.grey[200]),
        ],
      ),
    );
  }
}
