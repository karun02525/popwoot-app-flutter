import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/product_model.dart';
import 'package:popwoot/src/main/api/model/reviews_model.dart';
import 'package:popwoot/src/main/api/repositories/reviews_details_repository.dart';
import 'package:popwoot/src/main/ui/widgets/add_review_widget.dart';
import 'package:popwoot/src/main/ui/widgets/home_like_widget.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/rating_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/res/fonts.dart';

class ReviewDetails extends StatefulWidget {
  final String pid,pname;
  ReviewDetails({Key key,this.pid,this.pname}): super(key: key);

  @override
  _ReviewDetailsState createState() => _ReviewDetailsState(pid,pname);
}

class _ReviewDetailsState extends State<ReviewDetails> {
  final String pid,pname;
  _ReviewDetailsState(this.pid,this.pname);

  List<ReviewsList> items = [];
  ProductData productData;

  bool _isLoading = true;
  ReviewsDetailsRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository=ReviewsDetailsRepository(context);

    Timer(Duration(seconds: 1), () => getOnlyProduct(pid??'0'));
  }


  void getOnlyProduct(String pid){
    _repository.getOnlyProduct(pid).then((value) {
      findAllReviews(pid);
      productData = value;
    });
  }

  void findAllReviews(String pid){
    _repository.findAllReviews(pid).then((value) {
      setState(() {
        _isLoading=false;
        items = value;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            brightness: Brightness.light,
            titleSpacing: 2.0,
            centerTitle: true,
            title: TextWidget(
                title: pname??'Details',
                fontSize: AppFonts.toolbarSize,
                isBold: true)),
        body: _isLoading ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView.builder(
                itemCount: items.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return buildHeader(productData);
                  }
                  index -= 1;
                  return buildProductCard(context,items[index]);
                }));
  }

  Widget buildProductCard(BuildContext context, ReviewsList item,) {
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

  Widget paddingView(ReviewsList item){
    return Container(
      margin: EdgeInsets.only(left:7.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RatingWidget(rating:item.rating),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: TextWidget(title: item.comment??'', fontSize: 14.0),
          ),
          Divider(),
          HomeLikeCmt(item:item),
        ],
      ),
    );
  }




  Widget getHeadTitle(ReviewsList item) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          ImageLoadWidget(imageUrl:item.userimg,name:item.username??'',isProfile: true),
          setContent(item.username??'', item.pname??'', item.rdate??'---')
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
                title: '  reviewed      ',
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
  Widget buildHeader(ProductData item) {
    return Container(
      color: Colors.white,
      child: Column(
         children: <Widget>[
          ImageLoadWidget(imageUrl:productData.avatar),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:5.0,top: 5.0),
                child: RatingWidget(rating:item.nrating??0.0),
              ),
              Padding(
                padding: const EdgeInsets.only(right:10.0,top: 5.0),
                child: AddReviewWidget(data:{
                  'pid':productData.pid,
                  'pname':productData.pname,
                  'pdesc':productData.pdesc,
                  'ipath':productData.avatar,
                }),
              )
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(padding: EdgeInsets.only(left: 10.0,bottom: 10.0),
              child: TextWidget(
                  title: productData.pdesc??'N.A'),
            ),
          ),
          Container(height: 10.0, color: Colors.grey[200]),
        ],
      ),
    );
  }
}
