import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/product/review_details.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/fonts.dart';


class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  Dio dio;
  bool _isLoading = true;
  String barcodeScanRes,
      _value = "";

  @override
  void initState() {
    super.initState();
    dio = Dio();
    scanBarcodeNormal();
  }

 Future scanBarcodeNormal() async {
   barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
       "#ff6666", "Cancel", true, ScanMode.DEFAULT);
   if (barcodeScanRes != "-1") {
     getScanProductApiAsync(barcodeScanRes);
   }
 }
   void getScanProductApiAsync(String pcode) async {
     try {
       final response = await dio.get('${Config.getReviewDetailsUrl}/$pcode');
       debugPrint('print api object : ${Config.getReviewDetailsUrl}/$pcode ');
       if (response.statusCode == 200) {
         final responseBody = jsonDecode(jsonEncode(response.data));
         debugPrint('print api object :' + responseBody.toString());
         if (responseBody['status']) {
           _isLoading = true;
           var data=responseBody['data'];
         /*  Navigator.push(context,
               MaterialPageRoute(
                   builder: (context) => ReviewDetails(),
                   settings: RouteSettings(
                       arguments: ["Scanner", '5ee7dc0550f66a2dc4e0c856']
                   )
               )
           );*/

           // productData = responseBody['idata'];
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


   /*
   setState(() {
     _value = barcodeScanRes;
   });*/
 }

  void hideLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          centerTitle: true,
            title: TextWidget(title: "Scanner", color: Colors.black,fontSize: AppFonts.toolbarSize, isBold: true)),
        body: Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child:_isLoading ? Container(child: Center(child: CircularProgressIndicator()))
            :Container(child: Center(
            child: Column(
              children: <Widget>[
                RaisedButton.icon(
                  onPressed: () => {scanBarcodeNormal()},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  label: Text(
                    '  Try Again  ',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  color: Colors.grey[500],
                ),
                TextWidget(title: 'Product not available',),
              ],
            ),
          )
          ))
    );
  }
}
