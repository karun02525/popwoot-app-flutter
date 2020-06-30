
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:popwoot/src/main/api/model/category_model.dart';
import 'package:popwoot/src/main/api/model/comment_model.dart';
import 'package:popwoot/src/main/api/model/review_model.dart';
import 'package:popwoot/src/main/api/service/api_error_handle.dart';
import 'package:popwoot/src/main/api/service/custom_dio.dart';
import 'package:popwoot/src/main/config/constraints.dart';

class ReviewsRepository{

  BuildContext context;
  ReviewsRepository(BuildContext cnt){
    this.context=cnt;
  }

  Future<Idata> getOnlyReview(String rid) async {
      var dio =CustomDio.withAuthentication().instance;
     return await dio.get('${Config.getReviewCommentUrl}/$rid').then((res){
       if (res.statusCode == 200) {
         return ReviewModel.fromJson(res.data).idata;
       }
      }).catchError((e) {
       return ApiErrorHandel.errorHandel(context,e);
     });
  }

  Future<List<CommentList>> findAllComments(String rid) async {
    var dio =CustomDio.withAuthentication().instance;
    return await dio.get('${Config.getAllCommentUrl}/$rid/1').then((res){
      return CommentModel.fromJson(res.data).data;
    }).catchError((e) {
      return ApiErrorHandel.errorHandel(context,e);
    });
  }

  //Add comments
  Future<bool> addComment(Map<String, dynamic> params) async{
    var dio =CustomDio.withAuthentication().instance;
    return await dio.post(Config.doReviewCommentUrl, data: params).then((res) async {
      if (res.statusCode == 200) {
        var result = jsonDecode(jsonEncode(res.data));
        if (result['status']) {
          return true;
        }
      }
    }).catchError((e) {
      return ApiErrorHandel.errorHandel(context,e);
    });
  }


}