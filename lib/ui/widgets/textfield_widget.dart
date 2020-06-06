import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {

  final String hintText;
  int minLine=0;
  final Function onChanged;

  TextFieldWidget({
   this.hintText,
   this.minLine,
   this.onChanged
});


  @override
  Widget build(BuildContext context) {
    return TextField(
       maxLines: minLine,
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
