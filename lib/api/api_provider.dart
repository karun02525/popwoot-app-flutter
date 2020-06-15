import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:popwoot/constraints/constraints.dart';

import 'model/category/category_model.dart';
import 'model/post/post_model.dart';

class ApiProvider{
  Dio dio = Dio();

  Future<List<PostModel>> getDataPostFromApiAsync() async{
     var response= await dio.get('https://jsonplaceholder.typicode.com/posts');
     debugPrint("Data listPostData response : "+response.toString());


     if(response.statusCode ==200){
       final List rowData = jsonDecode(jsonEncode(response.data));
       List<PostModel> listPostData = rowData.map((f) => PostModel.fromJson(f)).toList();
        return listPostData;
     }else{
       return null;
     }
  }


  Future<List<CategoryModel>> getCategoryAllAsync() async{
    var response= await dio.get(Constraints.getAllCategoryUrl);
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