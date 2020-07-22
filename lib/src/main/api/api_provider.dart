import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:popwoot/src/main/config/constraints.dart';

import 'model/category/category_model.dart';

class ApiProvider{
  Dio dio = Dio();



  Future<List<CategoryModel>> getCategoryAllAsync() async{
    var response= await dio.get(Config.getAllCategoryUrl);
    debugPrint("Data CategoryModel response : "+response.toString());

    if(response.statusCode ==200){
      final List rowData = jsonDecode(jsonEncode(response.data));
      List<CategoryModel> listPostData = rowData.map((f) => CategoryModel.fromJson(f)).toList();
      return listPostData;
    }else{
      return null;
    }
  }




}