import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {

  final String hintText;
  int minLine=0;
  final Function onChanged;
  final TextEditingController controller;

  TextFieldWidget({
   this.hintText,
   this.minLine,
   this.onChanged,
   this.controller,
});


  @override
  Widget build(BuildContext context) {
    return TextField(
       maxLines: minLine,
        controller: controller,
        decoration: InputDecoration(
         hintText: hintText,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.red[200],
                  width: 8.0),
            )
        ),

    );
  }
}
