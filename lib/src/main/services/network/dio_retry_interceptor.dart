import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'dio_connectivity_request.dart';

class RetryOnChangeIntercepter extends Interceptor{
  final DioConnectivityRequest requestRetrier;

  RetryOnChangeIntercepter({
    @required this.requestRetrier,
  });


    @override
  Future onError(DioError err) async {
     if(_shouldRetry(err)){
        try {
          return requestRetrier.scheduleRequestRetry(err.request);
        } catch (e) {
          print(e);
        }
     }
     return err;
  }

  bool _shouldRetry(DioError err){
      return err.type == DioErrorType.DEFAULT &&
      err.error != null &&
      err.error is SocketException;
  }
}