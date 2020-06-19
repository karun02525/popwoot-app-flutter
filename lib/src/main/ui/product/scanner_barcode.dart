import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/product/review_details.dart';

class ScannerController {
  Dio dio;
  String barcodeScanRes;
  BuildContext context;
  bool isLoader;
  GlobalKey<ScaffoldState> globalKey;
  ScannerController(
      {@required this.context, this.isLoader = false, this.globalKey}) {
    dio = Dio();
    scanBarcodeNormal();
  }

  Future scanBarcodeNormal() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.DEFAULT);
    if (barcodeScanRes != "-1") {
      getScanProductApiAsync(barcodeScanRes);
    } else {
      hideLoader();
    }
  }

  void getScanProductApiAsync(String pcode) async {
    try {
      final response = await dio.get('${Config.getScannerUrl}/$pcode');
      debugPrint('print Scanner api object : ${Config.getScannerUrl}/$pcode ');
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        debugPrint('print Scanner api object :' + responseBody.toString());
        if (responseBody['status']) {
          isLoader = true;
          var data = responseBody['idata'];
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReviewDetails(),
                  settings:
                      RouteSettings(arguments: [data['pname'], data['pid']])));
        }
      }
    } on DioError catch (e) {
      var errorMessage = jsonDecode(jsonEncode(e.response.data));
      var statusCode = e.response.statusCode;

      debugPrint("print:Scanner  error :" + errorMessage.toString());
      debugPrint("print: Scanner statusCode :" + statusCode.toString());

      if (statusCode == 400) {
        hideLoader();
        snackBar(mgs:errorMessage['message']);
      }
      if (statusCode == 404) {
        hideLoader();
        snackBar(mgs:errorMessage['message'],color: Colors.green);
      } else if (statusCode == 401) {
        hideLoader();
        snackBar(mgs:errorMessage['message']);
      } else {
        hideLoader();
        snackBar(mgs:'Something went wrong',color: Colors.red);
      }
    }
  }

  void snackBar({String mgs,Color color}) {
    if (mgs != null) {
      if (globalKey != null) {
        final snackBar = SnackBar(content: Text(mgs),backgroundColor:color,);
        globalKey.currentState.showSnackBar(snackBar);
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(mgs),backgroundColor:color));
      }
    }
  }

  void hideLoader() {
    isLoader = false;
  }
}
