import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/ui/widgets/theme.dart';

class DropdownWidget extends StatelessWidget {

  final String hint;
  final dynamic value;
  final List<DropdownMenuItem<dynamic>> items;
  final Function onChanged;

  DropdownWidget({this.hint, this.value, this.items,this.onChanged});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 2.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(4.0)),
      child: DropdownButtonHideUnderline(
          child: Container(
            margin: EdgeInsets.only(left: 10.0,right: 20.0),
            child: DropdownButton(
              hint: Text(hint),
              value: value,
              style: TextStyle(color:Colors.black, fontFamily: font, fontSize: 15, fontWeight: FontWeight.w100),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36.0,
              isExpanded: true,
              items:items,
              onChanged:onChanged,
            ),
          )),
    );
  }
}

