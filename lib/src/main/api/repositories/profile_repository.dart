import 'dart:convert';

import 'package:popwoot/src/main/api/model/draft_model.dart';
import 'package:popwoot/src/main/config/constraints.dart';

import '../custom_dio.dart';


class ProfileRepository{

  Future<List<DraftList>> findAllDraft() {
      var dio =CustomDio.withAuthentication().instance;
     return dio.get(Config.getDraftUrl).then((res){
        return DraftModel.fromJson(res.data).data;
      });
  }
}