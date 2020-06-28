import 'dart:convert';

import 'package:popwoot/src/main/api/model/draft_model.dart';
import 'package:popwoot/src/main/api/model/home_reviews_model.dart';
import 'package:popwoot/src/main/config/constraints.dart';

import '../custom_dio.dart';


class ProfileRepository{

  Future<List<DraftList>> findAllDraft() {
      var dio =CustomDio.withAuthentication().instance;
     return dio.get(Config.getDraftUrl).then((res){
        return DraftModel.fromJson(res.data).data;
      });
  }

  Future<List<RevieswModel>> findAllReview() {
    var dio =CustomDio.withAuthentication().instance;
    return dio.get(Config.getHomeUrl).then((res){
      return HomeReviewModel.fromJson(res.data).data;
    });
  }
}