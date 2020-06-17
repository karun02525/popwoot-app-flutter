import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/res/fonts.dart';


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
            title: TextWidget(title: "Scanner", color: Colors.black,fontSize: AppFonts.toolbarSize, isBold: true)),
        body: Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: Center(
            child: TextWidget(title:"Data: $_value"),
          ),
        )
    );
  }
}
