import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/comment_model.dart';
import 'package:popwoot/src/main/api/model/review_model.dart';
import 'package:popwoot/src/main/api/repositories/reviews_repository.dart';
import 'package:popwoot/src/main/services/shared_preferences.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/rating_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/fonts.dart';

class AddComment extends StatefulWidget {
  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {

  bool _isLoading = true;
  String name,avatar;
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String rid = '';
  List<CommentList> items = [];
  Idata productData;
  ReviewsRepository _repository;

  @override
  void initState() {
    var pref=UserPreference();
    name=pref.name;
    avatar=pref.avatar;
    super.initState();
    _repository=ReviewsRepository(context);
  }

  void getOnlyReview(String rid){
    _repository.getOnlyReview(rid).then((value) {
        loadCommentList();
        productData = value;
    });
  }

  void loadCommentList(){
    _repository.findAllComments(rid).then((value) {
      setState(() {
        _isLoading=false;
         items = value;
      });
    });
  }


  void postApiCall(String mgs) async {
    Map<String, dynamic> params = {
      'rid': rid,
      'comment': mgs,
    };
    _repository.addComment(params).then((value) {
      if (value) {
        loadCommentList();
        Global.hideKeyboard();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List data = ModalRoute.of(context).settings.arguments;
    debugPrint("Comment Screen: " + data.toString());
    setState(() {
      rid = data[1]??'0';
      getOnlyReview(rid);
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
                            return buildProductCard(context,items[index]);
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



  Widget buildHeader(Idata item) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ImageLoadWidget(imageUrl: productData.ipath),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                child: RatingWidget(rating: item.astar??'0'),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, top: 5.0),
              //  child: AddReviewWidget(data: item),
              )
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: TextWidget(
                  title:
                  productData.pdesc??''),
            ),
          ),
          Container(height: 10.0, color: Colors.grey[200]),
        ],
      ),
    );
  }


  Widget buildProductCard(BuildContext context, CommentList item) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getHeadTitle(item),
          paddingView(item),
          Container(height: 3.0, color: Colors.grey[200]),
        ],
      ),
    );
  }

  Widget paddingView(CommentList item) {
    return Container(
      margin: EdgeInsets.only(left: 7.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 8.0),
            child: TextWidget(title: item.comment??'', fontSize: 14.0),
          ),
        ],
      ),
    );
  }

  Widget getHeadTitle(CommentList item) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          ImageLoadWidget(
              imageUrl: item.userimg, name: item.user??'', isProfile: true),
          setContent(item.user??'', item.rdate??'----')
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
                    imageUrl:avatar, name: name??'P', isProfile: true)),
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
