import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'theme.dart';

class TextWidget extends StatelessWidget {
  final String title;
  bool isBold;
  final Color color;
  double top;
  double bottom;
  double fontSize;
  TextWidget({this.title,this.color,this.isBold=false,this.top=0.0,this.bottom=0.0,this.fontSize=15.0,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: top,bottom: bottom),
      child: isBold ? Text(title, style: TextStyle(fontFamily: font, fontSize:fontSize, fontWeight: FontWeight.w700))
      : Text(title, style: TextStyle(color:color, fontFamily: font, fontSize:fontSize, fontWeight: FontWeight.w100)
      ),
    );
  }
}
