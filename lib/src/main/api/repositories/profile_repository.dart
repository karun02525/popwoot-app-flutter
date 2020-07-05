import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:popwoot/src/main/api/model/draft_model.dart';
import 'package:popwoot/src/main/api/model/home_reviews_model.dart';
import 'package:popwoot/src/main/api/service/api_error_handle.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/services/shared_preferences.dart';

import '../service/custom_dio.dart';

class ProfileRepository{

  BuildContext context;
  ProfileRepository(BuildContext cnt){
    this.context=cnt;
  }

  //Check Login
   loginCheck()  {
      var dio =CustomDio.withAuthentication().instance;
     return  dio.get(Config.loginCheckUrl).then((res){
       if(res.statusCode==200) {
         print('_______________________LoginCheck______________________________');
         print(res.statusCode.toString());
         print('_____________________________________________________');
       }
      }).catchError((e) {
        ApiErrorHandel.errorHandel(context,e);
     });
  }

  //Profile Draft
  Future<List<DraftList>> findAllDraft() async {
      var dio =CustomDio.withAuthentication().instance;
     return await dio.get(Config.getDraftUrl).then((res){
        return DraftModel.fromJson(res.data).data;
      }).catchError((e) {
        ApiErrorHandel.errorHandel(context,e);
     });
  }

  //Profile My Reviews
  Future<List<ReviewsModel>> findAllReview() async {
    var dio =CustomDio.withAuthentication().instance;
    return await dio.get(Config.getHomeUrl).then((res){
      return HomeReviewModel.fromJson(res.data).data;
    }).catchError((e) {
       ApiErrorHandel.errorHandel(context,e);
    });
  }


  Future<bool> loginUser(List data) async {
    var params = {
      "uname": data[0],
      "uemail": data[1],
      "avatar": data[2],
      "ltoken": data[3]
    };

    var dio = CustomDio().instance;
    return dio.post(Config.authenticateUrl, data: params).then((res) async {
      if (res.statusCode == 200) {
        var result = jsonDecode(jsonEncode(res.data));
        saveData(data,result['idata']['token']);
        return true;
      }
    }).catchError((e) {
      return ApiErrorHandel.errorHandel(context,e);
    });
  }

  void saveData(List data,String token){
    var pref=UserPreference();
    pref.name=data[0];
    pref.email=data[1];
    pref.avatar=data[2];
    pref.token=token;
    pref.isLogin=true;
  }
}