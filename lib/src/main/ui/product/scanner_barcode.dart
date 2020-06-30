import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:popwoot/src/main/api/repositories/scanner_repository.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/product/review_details.dart';

class ScannerController {

  String barcodeScanRes;
  BuildContext context;
  bool isLoader;
  GlobalKey<ScaffoldState> globalKey;
  ScannerRepository _repository;
  ScannerController({@required this.context, this.isLoader = false, this.globalKey}) {
    _repository=ScannerRepository(context);
    scanBarcodeNormal();
  }

  Future scanBarcodeNormal() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.DEFAULT);
    if (barcodeScanRes != "-1") {
      _repository.getScanProduct(barcodeScanRes??'');
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
}
