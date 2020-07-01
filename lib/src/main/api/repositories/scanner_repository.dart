import 'dart:convert';
import 'package:dio/src/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/service/api_error_handle.dart';
import 'package:popwoot/src/main/api/service/custom_dio.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/product/review_details.dart';

class ScannerRepository {
  BuildContext context;

  ScannerRepository(BuildContext cnt) {
    this.context = cnt;
  }

  void getScanProduct(String pcode) async {
    var dio = CustomDio.withAuthentication().instance;
    return await dio.get('${Config.getScannerUrl}/$pcode').then((res) {
      dataParse(res);
    }).catchError((e) {
      ApiErrorHandel.errorHandel(context, e);
    });
  }

  void dataParse(Response response) {
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(jsonEncode(response.data));
      if (responseBody['status']) {
        var data = responseBody['idata'];
        Navigator.push(context,MaterialPageRoute(
                builder: (context) => ReviewDetails(pid:data['pid'],pname:data['pname'])));
      }
    }
  }
}
