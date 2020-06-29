import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/service/api_error_handle.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../custom_dio.dart';

class ProductRepository {
  Future<bool> addReview(context,Map<String, dynamic> params) {

    var pd = ProgressDialog(context, type: ProgressDialogType.Normal);
    pd.style(message: 'Uploading file...');
    pd.show();

    var dio =CustomDio.withAuthentication().instance;
    return dio.post(Config.addReviewUrl, data: params).then((res) async {
      if (res.statusCode == 200) {
        var result = jsonDecode(jsonEncode(res.data));
        if (result['status']) {
          pd.hide();
           messageAlert(context,result['message'], 'Add Review');
          return true;
        } else {
          pd.hide();
          return false;
        }
      }
    }).catchError((e) {
      ApiErrorHandel.errorHandel(e);
      pd.hide();
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
