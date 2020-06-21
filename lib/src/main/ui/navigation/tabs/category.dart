import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/product/product_list.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List categoryList;
  Dio dio;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    dio = Dio();
    getCategoryAllAsync();
  }

  void getCategoryAllAsync() async {
    try {
      final response = await dio.get(Config.getAllCategoryUrl);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        if (responseBody['status']) {
          hideLoader();
          setState(() {
            categoryList = responseBody['data'];
          });
        }
      }
    } on DioError catch (e) {
      var errorMessage = jsonDecode(jsonEncode(e.response.data));
      var statusCode = e.response.statusCode;


      debugPrint("print: statusCode :" + statusCode.toString());

      if (statusCode == 400) {
        hideLoader();
        Global.toast(errorMessage['message']);
      } else if (statusCode == 401) {
        hideLoader();
        Global.toast(errorMessage['message']);
      } else {
        hideLoader();
        Global.toast('Something went wrong');
      }
    }
  }

  void getFollowAsync(String cid) async {
    try {
      final response = await dio.get('${Config.getFollowUrl}/$cid');
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        if (responseBody['status']) {
          hideLoader();
          setState(() {
            categoryList = responseBody['data'];
          });
        }
      }
    } on DioError catch (e) {
      var errorMessage = jsonDecode(jsonEncode(e.response.data));
      var statusCode = e.response.statusCode;


      debugPrint("print: statusCode :" + statusCode.toString());

      if (statusCode == 400) {
        hideLoader();
        Global.toast(errorMessage['message']);
      } else if (statusCode == 401) {
        hideLoader();
        Global.toast(errorMessage['message']);
      } else {
        hideLoader();
        Global.toast('Something went wrong');
      }
    }
  }

  void hideLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: ListView.builder(
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductList(),
                                  settings: RouteSettings(
                                      arguments: [categoryList[index]['cname'],categoryList[index]['id']])));
                        },
                        child: buildCardView(context, index));
                  }),
            ),
    );
  }

  Widget buildCardView(BuildContext context, int index) {
    final i = categoryList[index];
    return Container(
        margin: EdgeInsets.only(left: 2, right: 5),
        child: Card(
          elevation: 3,
          child: ListTile(
            leading: SizedBox(
                width: 80.0, child: ImageLoadWidget(imageUrl: i['cimage'])),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextWidget(title: i['cname'], isBold: true, fontSize: 12.0),
                FlatButton(
                    onPressed: () {
                      getFollowAsync(i['id']);
                    },
                    child: TextWidget(
                        title: 'Follow',
                        color: Colors.grey[400],
                        fontSize: 12.0))
              ],
            ),
            subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: TextWidget(title: i['cdetails'])),
          ),
        ));
  }
}
