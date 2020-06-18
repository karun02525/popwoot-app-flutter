import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/widgets/add_review_widget.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/rating_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/app_icons.dart';

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
    final item = items[index];
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: <Widget>[
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: getContent(item),
                    flex: 1,
                  ),
                  Expanded(
                    child: getImage(item),
                    flex: -1,
                  )
                ]),
            Divider(
              height: 25.0,
            ),
          ],
        ));
  }

  Widget getImage(item) {
    return Container(
        color: Colors.grey[100],
        width: 110.0,
        height: 90.0,
        child: ImageLoadWidget(imageUrl: item['ipath']));
  }

  Widget getContent(item) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextWidget(title: item['pname'], color: Colors.black, isBold: true),
          TextWidget(
              title:item['pdesc'],
              fontSize: 13.0,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          ratingAndReview(item),
          TextWidget(title: "mentioned in 0reviews"),
        ],
      ),
    );
  }

  Widget ratingAndReview(item) {
    return Row(
      children: <Widget>[
        RatingWidget(rating:item['nrating']),
        AddReviewWidget(data: [item['pid'],item['pname'],item['pdesc'],item['ipath']])
      ],
    );
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
