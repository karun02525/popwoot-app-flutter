import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/navigation/drawer_navigation.dart';
import 'package:popwoot/src/main/ui/product/review_details.dart';
import 'package:popwoot/src/main/ui/product/scanner_barcode.dart';
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
  List items = [];
  bool _isVisible = false;
  Dio dio;
  bool _isLoading = false;
  var _searchController = TextEditingController();
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    dio = Dio();
  }


    void getCategoryAllAsync(String query) async {
    _isLoading = true;
    try {
      final String _url = "api.github.com";
      final uri = Uri.https(_url, '/search/repositories', {
        'q': query,
        'sort': 'stars',
        'order': 'desc',
        'page': '0',
        'per_page': '25'
      });
      debugPrint("Github...." + uri.toString());

      final response = await dio.get(uri.toString());
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        hideLoader();
        setState(() {
          items = responseBody['items'];
        });
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

  void hideLoader() {
    setState(() {
      _isLoading = false;
    });
  }


  onSearch(String text) async {
    setState(() {
      if (text.isEmpty) {
        _isVisible = false;
        items.clear();
      } else {
        if(text.length>3) {
          getCategoryAllAsync(text);
          _isVisible = true;
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
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
                    controller: _searchController,
                    isRound: false,
                    onChanged: (value) {
                      onSearch(value);
                    },
                  ),
                  flex: 8),
              Expanded(
                  child: Visibility(
                      visible: _isVisible,
                      child: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            onSearch('');
                          })),
                  flex: 1),
              Expanded(
                  child: IconButton(
                    onPressed: () {
                      ScannerController(context: context,globalKey: globalKey);
                    },
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
          : items.length == 0
              ? Container(
                  child: Center(
                  child: Text("No data available"),
                ))
              : Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) =>
                          buildCardView(context, index)),
                ),
    );
  }

  Widget buildCardView(BuildContext context, int index) {
    final i = items[index];
    return Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Card(
          elevation: 3,
          child: ListTile(
            leading: CachedNetworkImage(imageUrl: i['owner']['avatar_url']),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextWidget(title: i['name'], isBold: true, fontSize: 12.0),
              ],
            ),
            subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextWidget(title: i['description']==null?"No Content":i['description'])),
          ),
        ));
  }
}
