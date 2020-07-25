import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/repositories/reviews_repository.dart';
import 'package:popwoot/src/main/services/shared_preferences.dart';
import 'package:popwoot/src/main/ui/product/add_comment.dart';
import 'package:popwoot/src/main/utils/dialog_bottomsheet.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/main/utils/utils.dart';
import 'package:popwoot/src/res/app_icons.dart';

import 'add_review_widget.dart';
import 'icon_widget.dart';

class HomeLikeCmt extends StatefulWidget {
  final dynamic item;
  bool isComment;

  HomeLikeCmt({Key key, this.item, this.isComment = true}) : super(key: key);

  @override
  _HomeLikeCmtState createState() => _HomeLikeCmtState(item);
}

class _HomeLikeCmtState extends State<HomeLikeCmt> {
  dynamic item;

  _HomeLikeCmtState(this.item);

  dynamic likeData;
  bool isLike = false;
  int likeCount = 0;
  String likeMsg = "Helpful";
  String rid = '';
  bool _isYoutube = false;
  String youtubeLink = '';
  int commentCount = 0;
  ReviewsRepository _repository;
  bool isMap = true;
  double lat,lng;

  @override
  void initState() {
    super.initState();
    _repository = ReviewsRepository(context);
    parseData();
  }

  void parseData() {
    rid = item.rid ?? '0';
    likeCount = item.nlike ?? 0;
    commentCount = item.ncomment ?? 0;
    youtubeLink = item.youtubeurl ?? '';
    isMap = item.map ?? true;
    lat = item.latitude ?? 0.0;
    lng = item.longitude ?? 0.0;

    if (item.nrating == 'Y') {
      isLike = true;
    } else {
      isLike = false;
    }

    if (youtubeLink.toString().contains('https://youtu')) {
      _isYoutube = true;
    } else
      _isYoutube = false;
  }

  void doLikes() {
    _repository.doLikes(rid).then((value) {
      if (value) {}
    });
  }

  void doLikeToggle() {
    doLikes();
    setState(() {
      if (isLike == false) {
        doLikeOrDlike(true);
        isLike = true;
      } else {
        doLikeOrDlike(false);
        isLike = false;
      }
    });
  }

  void doLikeOrDlike(bool flag) {
    setState(() {
      if (flag) {
        likeCount++;
      } else {
        likeCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconWidget(
              icon: isLike ? AppIcons.ic_thumb : AppIcons.ic_outline_up,
              mgs: '$likeCount $likeMsg',
              onTap: () {
                if (UserPreference().isLogin) {
                  doLikeToggle();
                } else {
                  Global.handleSignOut(context);
                }
              }),
          IconWidget(
            icon: AppIcons.ic_comment,
            mgs: '$commentCount Comment',
            isDisable: widget.isComment,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddComment(rid: item.rid, rname: item.pname),
                  ));
            },
          ),
          Visibility(
              child: InkWell(
                  splashColor: Colors.cyanAccent,
                  onTap: () {
                    Utils.plaYoutube(youtubeLink);
                  },
                  child: AppIcons.ic_youtube),
              visible: _isYoutube),
          isMap
              ? InkWell(
                  splashColor: Colors.cyanAccent,
                  onTap: () {
                    _modalBottomSheetMenu(context);},
                  child: AppIcons.ic_map)
              : Container(
                  height: 20,
                  width: 20,
                  child: Image.network(item?.savatar??''),
                ),
          AddReviewWidget(data: {
            "pid": item.pid,
            "pname": item.pname,
            "pdesc": item.pdesc,
            "ipath": item.avatar,
          }),
        ],
      ),
    );
  }

  void _modalBottomSheetMenu(context){
    final double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          return Container(
            height: height/2,
            child: BottomSheetDialog(),
          );
        });
  }
}
