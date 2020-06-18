import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/res/fonts.dart';

class TextFieldWidget extends StatelessWidget {
  bool isRound;
  final String hintText;
  final int minLine;
  final Function onChanged;
  final TextEditingController controller;

  TextFieldWidget({
    this.isRound = true,
    this.hintText,
    this.minLine,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (isRound) {
      return Container(
        child: TextField(
          maxLines: minLine,
          onChanged: onChanged,
          style: TextStyle(
              fontFamily: AppFonts.font,
              fontSize: 15,
              fontWeight: FontWeight.w100),
          textCapitalization: TextCapitalization.sentences,
          controller: controller,
          autofocus: false,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
              hintText: hintText,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red[200], width: 8.0),
              )),
        ),
      );
    } else {
      return Container(
          child: TextField(
              minLines: 1,
              style: TextStyle(
                  fontFamily: AppFonts.font,
                  fontSize: 15,
                  height: 1.4,
                  fontWeight: FontWeight.w700),
              controller: controller,
              autofocus: true,
              onChanged: onChanged,
              autocorrect: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                hintText: hintText,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              )));
    }
  }
}
