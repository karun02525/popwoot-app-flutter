import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/widgets/home_widget.dart';
import 'package:popwoot/src/main/ui/widgets/search_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';

import '../drawer_navigation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List items = [];
  Dio dio;
  bool _isLoading = true;

  @override
  void initState() {
    dio = Dio();
    super.initState();

  }

  void getHomeApiAsync() async {
    try {
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization': 'Bearer ${Config.token}'
      };

      final response = await dio.get(Config.getHomeUrl,
          options: Options(headers: requestHeaders));
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        if (responseBody['status']) {
          hideLoader();
          setState(() {
            items = responseBody['data'];
          });
        }
      }
    } on DioError catch (e) {
      var errorMessage = jsonDecode(jsonEncode(e.response.data));
      var statusCode = e.response.statusCode;

      debugPrint("print: error :" + errorMessage.toString());
      debugPrint("print: statusCode :" + statusCode.toString());

      if (statusCode == 400) {
        hideLoader();
        Global.toast(errorMessage['message']);
      } else if (statusCode == 401) {
        hideLoader();
        Global.toast(errorMessage['message']);
      } else {
        hideLoader();
       // Global.toast('Something went wrong');
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));

    setState(() {
      getHomeApiAsync();
    });

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
            ? Container(child: Center(child: CircularProgressIndicator()))
            : items.length == 0
                ? Container(child: Center(child: TextWidget(title: 'No items available',)))
                : ListView.builder(
                    itemCount: null == items ? 0 : items.length,
                    itemBuilder: (context, index) =>
                        HomeWidget(items: items, index: index)));
  }
}
