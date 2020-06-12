import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../../widgets/theme.dart';


class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String barcodeScanRes,
      _value = "";

  @override
  void initState() {
    super.initState();
     scanBarcodeNormal();
  }

 Future scanBarcodeNormal() async {
   barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
       "#ff6666", "Cancel", true, ScanMode.DEFAULT);

   setState(() {
     _value = barcodeScanRes;
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
            "Scanner",
            style: TextStyle(
                color: Colors.black,
                fontFamily: font,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: Center(
            child: Text("Data: $_value"),
          ),
        )
    );
  }
}
