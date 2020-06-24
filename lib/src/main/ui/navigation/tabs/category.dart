import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/product/product_list.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/search_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';

import '../drawer_navigation.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List categoryList;
  Dio dio;
  bool _isLoading = true;
  bool isFollow =false;
  String follow='';

  @override
  void initState() {
    super.initState();
    dio = Dio();
    getCategoryAllAsync();
  }

  void getCategoryAllAsync() async {
    try {

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization': 'Bearer ${Config.token}'
      };

      final response = await dio.get(Config.getAllCategoryUrl, options: Options(headers: requestHeaders));
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        if (responseBody['status']) {
          hideLoader();
          setState(() {
            debugPrint("Follow Category: data  "+responseBody.toString());
            categoryList = responseBody['data'];
          });
        }
      }
    } on DioError catch (e) {
      var errorMessage = jsonDecode(jsonEncode(e.response.data));
      var statusCode = e.response.statusCode;
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


  void getFollowAsync(String cid,isFlow) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization': 'Bearer ${Config.token}'
      };

      final response = await dio.get('${Config.getFollowUrl}/$cid', options: Options(headers: requestHeaders));
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        debugPrint("Follow Category: "+responseBody.toString());
        if (responseBody['status']) {
          setState(() {
            getCategoryAllAsync();
          });
        }
      }
    } on DioError catch (e) {
      var errorMessage = jsonDecode(jsonEncode(e.response.data));
      var statusCode = e.response.statusCode;
      debugPrint("Follow Category Error: "+errorMessage.toString());

      if (statusCode == 400) {
        Global.toast(errorMessage['message']);
      } else if (statusCode == 401) {
        Global.toast(errorMessage['message']);
      } else {
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
      appBar: AppBar(
        titleSpacing: 2.0,
        title: TextSearchWidget(),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          )
        ],
      ),
      drawer: NavigationDrawer(),
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
                      getFollowAsync(i['id'],i['follow'],);
                    },
                    child:i['follow']==false ? TextWidget(
                        title: 'Follow',
                        color: Colors.grey[400],
                        fontSize: 12.0):TextWidget(
                        title: 'Following',
                        color: Colors.lightBlue[400],
                        fontSize: 12.0)
                )
              ],
            ),
            subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: TextWidget(title: i['cdetails'])),
          ),
        ));
  }
}
