import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {

  final String hintText;
  final int minLine;
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
    return Container(
      child: TextField(
         maxLines: minLine,
          controller: controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
           hintText: hintText,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.red[200],
                    width: 8.0),
              )
          ),

      ),
    );
  }
}
