import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/service/api_error_handle.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../service/custom_dio.dart';

class AddProductRepository {
  ProgressDialog pd;
  BuildContext context;
  AddProductRepository(BuildContext cnt){
    this.context=cnt;
    pd = ProgressDialog(this.context, type: ProgressDialogType.Normal);
    pd.style(message: 'Loading...');
  }


  //Add Reviews
   addReviewDraft(Map<String, dynamic> params){
    var dio =CustomDio.withAuthentication().instance;
    dio.post(Config.addReviewUrl, data: params);
  }


  //Add Store
  Future<bool> addStore(Map<String, dynamic> params) async{
     pd.show();
    var dio =CustomDio.withAuthentication().instance;
    return await dio.post(Config.addStoreUrl, data: params).then((res) async {
      if (res.statusCode == 200) {
        pd.hide();
        var result = jsonDecode(jsonEncode(res.data));
        if (result['status']) {
           messageAlert(context,result['message'], 'Add Store');
          return true;
        }
      }
    }).catchError((e) {
      pd.hide();
      return ApiErrorHandel.errorHandel(context,e);
    });
  }

  //Add Reviews
  Future<bool> addReview(Map<String, dynamic> params) async{
     pd.show();
    var dio =CustomDio.withAuthentication().instance;
    return await dio.post(Config.addReviewUrl, data: params).then((res) async {
      if (res.statusCode == 200) {
        pd.hide();
        var result = jsonDecode(jsonEncode(res.data));
        if (result['status']) {
           messageAlert(context,result['message'], 'Add Review');
          return true;
        }
      }
    }).catchError((e) {
      pd.hide();
      ApiErrorHandel.errorHandel(context,e);
    });
  }

  //Add Category
  Future<bool> addCategory(Map<String, dynamic> params) async{
    pd.show();
    var dio =CustomDio.withAuthentication().instance;
    return await dio.post(Config.addCategoryUrl, data: params).then((res) async {
      if (res.statusCode == 200) {
        pd.hide();
        var result = jsonDecode(jsonEncode(res.data));
        if (result['status']) {
          messageAlert(context,result['message'], 'Category');
          return true;
        }
      }
    }).catchError((e) {
      pd.hide();
      return ApiErrorHandel.errorHandel(context,e);
    });
  }

  //Add Product
  Future<bool> addProduct(Map<String, dynamic> params) async{
    pd.show();
    var dio =CustomDio.withAuthentication().instance;
    return await dio.post(Config.addProductUrl, data: params).then((res) async {
      if (res.statusCode == 200) {
        pd.hide();
        var result = jsonDecode(jsonEncode(res.data));
        if (result['status']) {
          messageAlert(context,result['message'], 'Product');
          return true;
        }
      }
    }).catchError((e) {
      pd.hide();
      return ApiErrorHandel.errorHandel(context,e);
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
