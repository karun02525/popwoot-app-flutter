import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/navigation/drawer_navigation.dart';
import 'package:popwoot/src/main/ui/widgets/button_widget.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/ui/widgets/textfield_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/app_icons.dart';
import 'package:popwoot/src/res/fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';

class GlobalSearch extends StatefulWidget {
  @override
  _GlobalSearchState createState() => _GlobalSearchState();
}

class _GlobalSearchState extends State<GlobalSearch> {
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
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          titleSpacing: 2.0,
          centerTitle: true,
          leading: BackButton(color: Colors.black),
          title: Row(
            children: <Widget>[
              Expanded(
                  child: TextFieldWidget(
                    hintText: 'Search...',
                    isRound: false,
                  ),
                  flex: 8),
              Expanded(
                  child: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.black,
                      ),
                      onPressed: () {}),
                  flex: 1),
              Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(AppIcons.ic_scanner, color: Colors.black),
                  ),
                  flex: 2),
            ],
          )),
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
                  itemBuilder: (context, index) =>
                      buildCardView(context, index)),
            ),
    );
  }

  Widget buildCardView(BuildContext context, int index) {
    final i = categoryList[index];
    return Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Card(
          elevation: 3,
          child: ListTile(
            leading:
                ImageLoadWidget(imageUrl: Config.baseImageUrl + i['cimage']),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextWidget(title: i['cname'], isBold: true, fontSize: 12.0),
                FlatButton(
                    onPressed: () {},
                    child: TextWidget(
                        title: 'Follow',
                        color: Colors.grey[400],
                        fontSize: 12.0))
              ],
            ),
            subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextWidget(title: i['cdetails'])),
          ),
        ));
  }
}
