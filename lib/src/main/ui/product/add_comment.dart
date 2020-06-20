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

  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    dio = Dio();
  }

  void getProductApiAsync(String pcode) async {
    try {
      final response = await dio.get('${Config.getReviewDetailsUrl}/$pcode');
      debugPrint('print api object : ${Config.getReviewDetailsUrl}/$pcode ');
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        debugPrint('print api object :' + responseBody.toString());
        if (responseBody['status']) {
          getProductReviewApiAsync(pcode);
          productData = responseBody['idata'];
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

  void getProductReviewApiAsync(String pcode) async {
    try {
      final response =
          await dio.get('${Config.getReviewListDetailsUrl}/$pcode/1');
      debugPrint('print api List : ${Config.getReviewListDetailsUrl}/$pcode/1');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        if (responseBody['status']) {
          debugPrint('print api List :' + responseBody.toString());
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
    String pid = data[1];
    setState(() {
      getProductApiAsync(pid);
    });

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            titleSpacing: 2.0,
            centerTitle: true,
            leading: BackButton(color: Colors.black),
            title: TextWidget(
                title: "${data[0]}",
                color: Colors.black,
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
          RatingWidget(rating: item['astar']),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: TextWidget(title: item['pdesc'], fontSize: 14.0),
          ),
          HomeLikeCmt(item: item),
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
          setContent(item['user'], item['pname'], item['rdate'])
        ],
      ),
    );
  }

  Widget setContent(String name, String pname, String rdate) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextWidget(
                title: name.toString().toUpperCase(),
                fontSize: 13.0,
                isBold: true,
              ),
              TextWidget(
                title: '  reviewed            ',
                fontSize: 12.0,
              ),
              TextWidget(
                title: '@$rdate',
                fontSize: 10.0,
              )
            ],
          ),
        ],
      ),
    );
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

  Widget bottomNavigationBarComment() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: _isVisible ? 60 : 0.0,
      child: BottomAppBar(
        color: Colors.deepOrange[200],
        elevation: 5.0,
        child: Container(
            height: 60,
            width: double.infinity,
            child: ListTile(
              leading: ImageLoadWidget(
                  imageUrl: Config.avatar, name: 'Kaju', isProfile: true),
              title: TextField(
                  decoration: new InputDecoration(
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      hintText: "Type in your text",
                      fillColor: Colors.white70)),
            )),
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
            Padding(padding: EdgeInsets.only(left: 5.0), child:ImageLoadWidget(imageUrl:Config.avatar1,name:'Kaju',isProfile: true)),
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: 'Comment'),
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
    _textController.clear();
    _focusNode.requestFocus();
  }
}

/*

    return  Container(
       width: double.infinity,
         child: Row(
           children: [
             ImageLoadWidget(imageUrl:Config.avatar,name:'Kaju',isProfile: true),
             TextField(decoration: InputDecoration(
                hintText: "Enter comment"
             ),
             )
           ],
         )
    );*/
