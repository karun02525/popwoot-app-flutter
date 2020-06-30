import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/products_model.dart';
import 'package:popwoot/src/main/api/service/api_error_handle.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import '../service/custom_dio.dart';

class ProductRepository {
  BuildContext context;
  ProductRepository(BuildContext cnt){
    this.context=cnt;
  }

  Future<List<ProductListData>> findAllProducts(String cid) async {
    var dio = CustomDio.withAuthentication().instance;
    return await dio.get('${Config.geProductsUrl}/$cid').then((res) {
      return ProductsModel.fromJson(res.data).data;
    }).catchError((e) {
      return ApiErrorHandel.errorHandel(context, e);
    });
  }


}
