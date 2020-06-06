import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class TextWidget extends StatelessWidget {
  final String title;
  TextWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0,bottom: 3.0),
      child: Text(title,
          style: TextStyle(
              fontFamily: font, fontSize: 15, fontWeight: FontWeight.w700)),
    );
  }
}
