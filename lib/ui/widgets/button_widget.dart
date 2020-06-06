import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Function onPressed;
  ButtonWidget({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 40.0, bottom: 3.0),
        child:SizedBox(
          width: double.infinity,
          height: 50.0,
         child: RaisedButton(
          color: Colors.deepOrangeAccent,
          textColor: Colors.white,
          splashColor: Colors.purpleAccent,
          onPressed: () => {onPressed},
          child: Text(title,
              style: TextStyle(
                  fontFamily: font, fontSize: 15, fontWeight: FontWeight.w700)),
        )));
  }
}