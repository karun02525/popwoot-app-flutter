import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/res/fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Function onPressed;
  bool isBold;
  double top;
  double left;
  double right;
  double bottom;
  ButtonWidget({
    this.title,
    this.isBold = false,
    this.onPressed,
    this.top = 40.0,
    this.bottom = 0.0,
    this.left = 0.0,
    this.right = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top:top, bottom:bottom,right: right,left: left),
        child: SizedBox(
            width: double.infinity,
            height: 50.0,
            child: isBold
                ? RaisedButton(
                    color: Colors.deepOrangeAccent,
                    textColor: Colors.white,
                    splashColor: Colors.purpleAccent,
                    onPressed: onPressed,
                    child: Text(title,
                        style: TextStyle(
                            fontFamily: AppFonts.font,
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                  )
                : RaisedButton(
                    color: Colors.deepOrangeAccent,
                    textColor: Colors.white,
                    splashColor: Colors.purpleAccent,
                    onPressed: onPressed,
                    child: Text(title,
                        style: TextStyle(
                            fontFamily: AppFonts.font,
                            fontSize: 15,
                            fontWeight: FontWeight.w100)),
                  )));
  }
}
