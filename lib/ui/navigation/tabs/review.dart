import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:popwoot/ui/product/add_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:popwoot/constraints/constraints.dart';
import 'package:popwoot/ui/widgets/global.dart';
import '../../widgets/theme.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  List items=[];
  Dio dio;
  bool _isLoading=true;

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
      final response = await dio.get(Constraints.getDefaultReviewUrl);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        if (responseBody['status']) {
          debugPrint("print: error :" + responseBody.toString());
         // hideLoader();
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
  void hideLoader(){
    setState(() {
      _isLoading=false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          "Search & Review",
          style: TextStyle(
              color: Colors.black,
              fontFamily: font,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              getSearch(),
              Divider(
                height: 10,
                color: Colors.black,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: items?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                             child: buildCardView(context, index),
                            onTap:  () => Scaffold
                                .of(context)
                                .showSnackBar(SnackBar(content: Text(index.toString())))

                        );
                      })),
            ],
          )),
    );
  }

  Widget buildCardView(BuildContext context, int index) {
    return Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              getImage(Constraints.baseImageUrl+items[index]['ipath']),
              getContent(items[index]['pid'],items[index]['pname'],items[index]['pdesc'],items[index]['ipath'], 1,2),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10),
              child: Text(
                items[index]['pdesc'].toString(),
                style: TextStyle(
                    fontFamily: font,
                    fontWeight: FontWeight.w100,
                    fontSize: 13.0),
              ),
            ),
            Divider(
              height: 25.0,
            ),
          ],
        ));
  }

  Widget getImage(String url) {
    return Container(
        padding: EdgeInsets.only(left: 10.0, top: 10.0),
        width: 170.0,
        height: 130.0,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.fill,
        ));
  }

  Widget getContent(String pid, String pname,String pdesc, String ipath, int rating, int review) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              pname,
              style: TextStyle(
                  fontFamily: font,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0),
            ),
          ),
          setStar(rating),
          FlatButton.icon(
            onPressed: () {
              Navigator.push(context,
                 MaterialPageRoute(
                   builder: (context) => AddReview(),
                   settings: RouteSettings(
                     arguments: [pid,pname,pdesc,ipath]
                   )
                 )
              );
               /* Navigator.pushNamed(context, '/add_review',
                  arguments: 'karun..............'
                );*/
            },
            splashColor: Colors.cyanAccent,
            icon: Icon(
              Icons.open_in_new,
              size: 20.0,
            ),
            label: Text(
              "Add Review",
              style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14.0,
                  fontWeight: FontWeight.w100,
                  fontFamily: font),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "mentioned in $review reviews",
              style: TextStyle(
                  fontFamily: font,
                  fontWeight: FontWeight.w100,
                  fontSize: 13.0),
            ),
          ),
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
          itemSize: 25.0, onRatingUpdate: (double rating) {  },
        ));
  }

  getSearch() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Icon(Icons.search),
        ),
        SizedBox(
         width:300.0,
        child:TextField(
           onChanged: null,
          decoration: InputDecoration(
              labelText: _value,
              border: InputBorder.none, hintText: 'What are you looking for'),
        )),
        Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: IconButton(
            onPressed: scanBarcodeNormal,
            icon: Icon(Icons.filter_center_focus),
          ),
        )
      ],
    ));
  }
}
