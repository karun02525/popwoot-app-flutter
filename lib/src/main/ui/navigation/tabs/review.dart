import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/product/add_review.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/app_icons.dart';
import 'package:popwoot/src/res/fonts.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  var _serachController = TextEditingController();
  List items = [];
  List _serachItem = [];
  Dio dio;
  bool _isLoading = true;

  String barcodeScanRes, _value = "What are you looking for";

  Future scanBarcodeNormal() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.DEFAULT);
    setState(() {
      _value = barcodeScanRes;
    });
  }

  @override
  void initState() {
    super.initState();
    dio = Dio();
    getReviewSearchAllAsync();
  }

  void getReviewSearchAllAsync() async {
    try {
      final response = await dio.get(Config.getDefaultReviewUrl);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        if (responseBody['status']) {
          debugPrint("print: error :" + responseBody.toString());
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
    return Scaffold(
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 5),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                          itemCount: items?.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                child: buildCardView(context, index),
                                onTap: () => Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text(index.toString()))));
                          })),
                ],
              )),
    );
  }

  Widget buildCardView(BuildContext context, int index) {
    final i = items[index];
    return Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                child: getContent(
                    i['pid'], i['pname'], i['pdesc'], i['ipath'], 1, 2),
                flex: 1,
              ),
              Expanded(
                child: getImage(Config.baseImageUrl + i['ipath']),
                flex: -1,
              )
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10),
              child: TextWidget(title: i['pdesc'].toString(), fontSize: 13.0),
            ),

            ratingReview(),

            Divider(
              height: 25.0,
            ),
          ],
        ));
  }

  Widget ratingReview() {
    return Row(
      children: <Widget>[
        setStar(3),
        FlatButton.icon(
            onPressed: () {
              /*       Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddReview(),
                        settings: RouteSettings(
                            arguments: [pid, pname, pdesc, ipath])));*/
            },
            splashColor: Colors.cyanAccent,
            icon: Icon(
              Icons.open_in_new,
              size: 20.0,
            ),
            label: TextWidget(
              title: "Add Review",
              color: Colors.grey[400],
              fontSize: 14.0,
            )),
      ],
    );
  }

  Widget getImage(String url) {
    return Container(
        padding: EdgeInsets.only(left: 10.0),
        width: 110.0,
        height: 90.0,
        child: ImageLoadWidget(
          imageUrl: url,
        ));
  }

  Widget getContent(String pid, String pname, String pdesc, String ipath,
      int rating, int review) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child:
                  TextWidget(title: pname, color: Colors.black, isBold: true)),
          Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextWidget(
                  title: "mentioned in $review reviews", color: Colors.black)),
        ],
      ),
    );
  }

  Widget setStar(int rating) {
    return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 1),
        child: FlutterRatingBar(
          initialRating: rating.toDouble(),
          fillColor: Colors.amber,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemSize: 25.0,
          onRatingUpdate: (double rating) {},
        ));
  }

  getSearch() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(Icons.search),
        ),
        SizedBox(
            width: 300.0,
            child: TextField(
              onChanged: null,
              controller: _serachController,
              decoration: InputDecoration(
                  labelText: _value,
                  border: InputBorder.none,
                  hintText: 'What are you looking for'),
            )),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: IconButton(
            onPressed: scanBarcodeNormal,
            icon: Icon(AppIcons.ic_scanner),
          ),
        )
      ],
    ));
  }
}
