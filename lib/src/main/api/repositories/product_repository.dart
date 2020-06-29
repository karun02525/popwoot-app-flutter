import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/service/api_error_handle.dart';
import 'package:popwoot/src/main/config/constraints.dart';

import '../custom_dio.dart';

class ProductRepository {
  Future<bool> addReview(context,Map<String, dynamic> params) {
    var dio =CustomDio.withAuthentication().instance;
    return dio.post(Config.addReviewUrl, data: params).then((res) async {
      if (res.statusCode == 200) {
        var result = jsonDecode(jsonEncode(res.data));
        if (result['status']) {
           messageAlert(context,result['message'], 'Add Review');
          return true;
        } else {
          return false;
        }
      }
    }).catchError((e) {
      ApiErrorHandel.errorHandel(e);
      return false;
    });
  }




  messageAlert(context,String msg, String ttl) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: CupertinoAlertDialog(
                title: Text(ttl),
                content: Text(msg),
                actions: <Widget>[
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Column(
                      children: <Widget>[Text('Okay')],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        });
  }
}
