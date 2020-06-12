import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/ui/shared/global.dart';

class DialogDemo extends StatefulWidget {
  @override
  _DialogDemoState createState() => _DialogDemoState();
}

class _DialogDemoState extends State<DialogDemo> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
             title: Text("Dialog Demo"),
           ),
         body: Container(
            child: Center(
              child: RaisedButton(
                onPressed: (){
                  createAlertDialog(context).then((value) {
                     Global.toast(value);
                  });
                },
                child: Text("Alert"),
              ),
            ),
         ),
    );
  }

  Future<String> createAlertDialog(BuildContext context){
    var name= TextEditingController();
    return showDialog(context:context,builder: (context){
               return AlertDialog(
                     title: Text("Your Name"),
                     content: TextField(
                       controller:name,
                     ),
                 actions: <Widget>[
                   MaterialButton(
                     elevation: 6.0,
                     child: Text("Done"),
                     onPressed: (){
                       Navigator.of(context).pop(name.text.toString());
                     },
                   )
                 ],
               );
    });

  }


}
