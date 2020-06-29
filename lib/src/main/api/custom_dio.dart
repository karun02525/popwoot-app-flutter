import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:popwoot/src/main/services/shared_preferences.dart';

class CustomDio{
  var _dio;
  CustomDio(){
    _dio=Dio();
  }


  CustomDio.withAuthentication(){
    _dio=Dio();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest:_onRequest,onResponse:_onResponse,onError: _onError
    ));
  }

  Dio get instance=>_dio;
  _onRequest(RequestOptions options) async {
    options.headers['authorization']='Bearer '+UserPreference().token;
  }

  _onResponse(Response e) {
    return e;
  }

  _onError(DioError e) {
    return e;
  }
}