import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/home_reviews_model.dart';
import 'package:popwoot/src/main/api/repositories/profile_repository.dart';
import 'package:popwoot/src/main/api/repositories/reviews_repository.dart';
import 'package:popwoot/src/main/services/shared_preferences.dart';
import 'package:popwoot/src/main/ui/product/add_comment.dart';
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
  String likeMsg = "Like";
  String rid = '';
  bool _isYoutube = false;
  String youtubeLink = '';
  int commentCount = 0;
  ReviewsRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = ReviewsRepository(context);
    parseData();
  }

  void parseData() {
    rid = item.id ?? '0';
    likeCount = item.nlike ?? 0;
    commentCount = item.ncomment ?? 0;
    youtubeLink = item.youtubeurl ?? '';

    if (item.nrating == 'Y') {
      isLike = true;
      likeMsg = 'Likes';
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
        likeMsg = 'Likes';
      } else {
        likeCount--;
        if (likeCount == 0) {
          likeMsg = 'Like';
        }
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
          Visibility(
              child: InkWell(
                  splashColor: Colors.cyanAccent,
                  onTap: () {
                    Utils.plaYoutube(youtubeLink);
                    // Utils.openYoutube(youtubeLink);
                  },
                  child: AppIcons.ic_youtube),
              visible: _isYoutube),
          IconWidget(
              icon: isLike ? Icons.favorite : Icons.favorite_border,
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
                        AddComment(rid: item.id, rname: item.pname),
                  ));
            },
          ),
          AddReviewWidget(data: {
            "pid": item.pid,
            "pname": item.pname,
            "pdesc": item.pdesc,
            "ipath": item.ipath,
          }),
        ],
      ),
    );
  }
}
