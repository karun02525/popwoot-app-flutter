
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:popwoot/src/main/api/model/category_model.dart';
import 'package:popwoot/src/main/api/model/store_model.dart';
import 'package:popwoot/src/main/api/service/api_error_handle.dart';
import 'package:popwoot/src/main/api/service/custom_dio.dart';
import 'package:popwoot/src/main/config/constraints.dart';

class CategoryRepository{

  BuildContext context;
  CategoryRepository(BuildContext cnt){
    this.context=cnt;
  }

  Future<List<DataList>> findAllCategory() async {
      var dio =CustomDio.withAuthentication().instance;
     return await dio.get(Config.getAllCategoryUrl).then((res){
        return CategoryModel.fromJson(res.data).data;
      }).catchError((e) {
        ApiErrorHandel.errorHandel(context,e);
     });
  }

  Future<List<StoreData>> findAllStore() async {
      var dio =CustomDio.withAuthentication().instance;
     return await dio.get(Config.getAllStoreUrl).then((res){
        return StoreModel.fromJson(res.data).data;
      }).catchError((e) {
        ApiErrorHandel.errorHandel(context,e);
     });
  }



  Future<bool> doFollow(String cid) async {
      var dio =CustomDio.withAuthentication().instance;
     return await dio.get('${Config.getFollowUrl}/$cid').then((res){
        if (res.statusCode == 200) {
          final responseBody = jsonDecode(jsonEncode(res.data));
          if (responseBody['status']) {
              return true;
          }}
      }).catchError((e) {
       return ApiErrorHandel.errorHandel(context,e);
     });
  }
}