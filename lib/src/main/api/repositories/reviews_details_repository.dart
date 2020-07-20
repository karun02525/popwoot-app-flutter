import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:popwoot/src/main/api/model/comment_model.dart';
import 'package:popwoot/src/main/api/model/product_model.dart';
import 'package:popwoot/src/main/api/model/reviews_model.dart';
import 'package:popwoot/src/main/api/service/api_error_handle.dart';
import 'package:popwoot/src/main/api/service/custom_dio.dart';
import 'package:popwoot/src/main/config/constraints.dart';

class ReviewsDetailsRepository {
  BuildContext context;
  ReviewsDetailsRepository(BuildContext cnt) {
    this.context = cnt;
  }

  Future<ProductData> getOnlyProduct(String pid) async {
    var dio = CustomDio.withAuthentication().instance;
    return await dio.get('${Config.getReviewDetailsUrl}/$pid').then((res) {
      if (res.statusCode == 200) {
        return ProductModel.fromJson(res.data).data;
      }
    }).catchError((e) {
      return ApiErrorHandel.errorHandel(context, e);
    });
  }

  Future<List<ReviewsList>> findAllReviews(String pid) async {
    var dio = CustomDio.withAuthentication().instance;
    return await dio.get('${Config.getReviewListDetailsUrl}/$pid/1').then((res) {
      return ReviewsModel.fromJson(res.data).data;
    }).catchError((e) {
      return ApiErrorHandel.errorHandel(context, e);
    });
  }
}
