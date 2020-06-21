import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/widgets/add_review_widget.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/fonts.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List productList = [];
  Dio dio;
  bool _isLoading = true;
  String cid = '';

  @override
  void initState() {
    super.initState();
    dio = Dio();
  }

  void getProductAllAsync() async {
    try {
      final response = await dio.get('${Config.geProductsUrl}/$cid');
      debugPrint("product list url: : '${Config.geProductsUrl}/$cid'");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        debugPrint("product list response :" + responseBody.toString());

        if (responseBody['status']) {
          hideLoader();
          setState(() {
            productList = responseBody['data'];
          });
        }
      }
    } on DioError catch (e) {
      var errorMessage = jsonDecode(jsonEncode(e.response.data));
      var statusCode = e.response.statusCode;

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
    cid = data[1];
    debugPrint("product list:" + data.toString());
    getProductAllAsync();

    return Scaffold(
      appBar: AppBar(
          titleSpacing: 2.0,
          title: TextWidget(
              title: data[0], fontSize: AppFonts.toolbarSize, isBold: true)),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : productList.length == 0
              ? Container(
                  child: Center(
                  child: TextWidget(title: "No data available"),
                ))
              : Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (context, index) =>
                          buildCardView(context, index)),
                ),
    );
  }

  Widget buildCardView(BuildContext context, int index) {
    final i = productList[index];
    return Container(
        margin: EdgeInsets.only(left: 2, right: 5),
        child: Card(
          elevation: 3,
          child: ListTile(
            leading: SizedBox(
                width: 80.0, child: ImageLoadWidget(imageUrl: i['imgpath'])),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextWidget(title: i['pname'], isBold: true, fontSize: 14.0),
                AddReviewWidget(data: {
                  "pid": i['id'],
                  "pname": i['pname'],
                  "pdesc": i['pdescription'],
                  "ipath": i['imgpath'],
                }),
              ],
            ),
            subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: TextWidget(title: i['pdescription'], fontSize: 12.0)),
          ),
        ));
  }
}
