
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:popwoot/src/main/api/model/category_model.dart';
import 'package:popwoot/src/main/api/model/search_model.dart';
import 'package:popwoot/src/main/api/service/api_error_handle.dart';
import 'package:popwoot/src/main/api/service/custom_dio.dart';
import 'package:popwoot/src/main/config/constraints.dart';

class SearchRepository{

  BuildContext context;
  SearchRepository(BuildContext cnt){
    this.context=cnt;
  }

  Future<List<SearchList>> searchReviews(String query) async {
      var dio =CustomDio.withAuthentication().instance;
     return await dio.get('${Config.getDefaultReviewUrl}/2/$query').then((res){
        return SearchModel.fromJson(res.data).data;
      }).catchError((e) {
       return ApiErrorHandel.errorHandel(context,e);
     });
  }

}