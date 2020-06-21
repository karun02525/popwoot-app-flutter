import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/widgets/add_review_widget.dart';
import 'package:popwoot/src/main/ui/widgets/home_like_widget.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/rating_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/ui/widgets/textfield_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/fonts.dart';

class AddComment extends StatefulWidget {
  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  List items = [];
  dynamic productData;
  Dio dio;
  bool _isLoading = true;

  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String rid = '';

  @override
  void initState() {
    super.initState();
    dio = Dio();
  }

  void getProductApiAsync() async {
    try {
      final response = await dio.get('${Config.getReviewCommentUrl}/$rid');
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        if (responseBody['status']) {
          getProductReviewApiAsync();
          productData = responseBody['idata'];
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

  void getProductReviewApiAsync() async {
    try {
      final response = await dio.get('${Config.getAllCommentUrl}/$rid/1');
      if (response.statusCode == 200) {
        hideLoader();
        final responseBody = jsonDecode(jsonEncode(response.data));
        if (responseBody['status']) {
          setState(() {
            items = responseBody['data'];
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

  //..................Post Api.........

  void postApiCall(String mgs) async {
    Map<String, dynamic> params = {
      'rid': rid,
      'comment': mgs,
    };

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer ${Config.token}'
    };
    debugPrint("Comment Screen Param: " + params.toString());

    try {
      final response = await dio.post(Config.doReviewCommentUrl,
          data: params, options: Options(headers: requestHeaders));

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        debugPrint("Comment Screen responseBody : " + responseBody.toString());
        if (responseBody['status']) {
          getProductReviewApiAsync();
        }
      }
    } on DioError catch (e) {
      var errorMessage = jsonDecode(jsonEncode(e.response.data));
      var statusCode = e.response.statusCode;
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
    List data = ModalRoute.of(context).settings.arguments;
    debugPrint("Comment Screen: " + data.toString());
    setState(() {
      rid = data[1];
      getProductApiAsync();
    });

    return Scaffold(
        appBar: AppBar(
            brightness: Brightness.light,
            titleSpacing: 2.0,
            centerTitle: true,
            title: TextWidget(
                title: "${data[0]}",
                fontSize: AppFonts.toolbarSize,
                isBold: true)),
        body: _isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                children: [
                  Flexible(
                      child: ListView.builder(
                          itemCount: items.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return buildHeader(productData);
                            }
                            index -= 1;
                            return buildProductCard(context, index);
                          })),
                  Divider(height: 1.0),
                  Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).cardColor),
                    child: _buildTextComposer(),
                  ),
                ],
              ));
  }

  Widget buildProductCard(BuildContext context, int index) {
    var item = items[index];
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getHeadTitle(item, index),
          paddingView(item),
          Container(height: 3.0, color: Colors.grey[200]),
        ],
      ),
    );
  }

  Widget paddingView(item) {
    return Container(
      margin: EdgeInsets.only(left: 7.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 8.0),
            child: TextWidget(title: item['comment'], fontSize: 14.0),
          ),
        ],
      ),
    );
  }

  Widget getHeadTitle(item, index) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          ImageLoadWidget(
              imageUrl: item['userimg'], name: item['user'], isProfile: true),
          setContent(item['user'], item['rdate'])
        ],
      ),
    );
  }

  Widget setContent(String name, String rdate) {
    return Row(children: <Widget>[
      TextWidget(
        title: name.toString().toUpperCase(),
        fontSize: 13.0,
        isBold: true,
      ),
      TextWidget(
        title: '   Commented',
        fontSize: 10.0,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: TextWidget(
          title: '@$rdate',
          fontSize: 10.0,
        ),
      )
    ]);
  }

  Widget buildHeader(item) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ImageLoadWidget(imageUrl: productData['ipath']),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                child: RatingWidget(rating: item['astar']),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, top: 5.0),
                child: AddReviewWidget(data: item),
              )
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: TextWidget(
                  title:
                      productData['pdesc'] == null ? "" : productData['pdesc']),
            ),
          ),
          Container(height: 10.0, color: Colors.grey[200]),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        color: Colors.orange[100],
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: ImageLoadWidget(
                    imageUrl: Config.avatar1, name: 'Kaju', isProfile: true)),
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(hintText: 'Comment'),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) {
      Global.toast('Please type some comment');
    } else {
      _focusNode.unfocus();
      _textController.clear();
      postApiCall(text);
    }
  }
}
