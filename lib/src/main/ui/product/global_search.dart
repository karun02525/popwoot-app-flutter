import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:popwoot/src/main/api/model/search_model.dart';
import 'package:popwoot/src/main/api/repositories/search_repository.dart';
import 'package:popwoot/src/main/ui/product/scanner_barcode.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/rating_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/ui/widgets/textfield_widget.dart';
import 'package:popwoot/src/res/app_icons.dart';

class GlobalSearch extends StatefulWidget {
  @override
  _GlobalSearchState createState() => _GlobalSearchState();
}

class _GlobalSearchState extends State<GlobalSearch> {
  bool _isVisible = false;
  bool _isLoading = false;
  var _searchController = TextEditingController();
  final globalKey = GlobalKey<ScaffoldState>();

  SearchRepository  _repository;
  List<SearchList> items=[];

  @override
  void initState() {
    super.initState();
    _repository=SearchRepository(context);
  }

  void _search(String query) {
    _repository.searchReviews(query).then((value) {
      setState(() {
        _isLoading=false;
        items=value;
      });
    });
  }


  onSearch(String text) async {
    setState(() {
      if (text.isEmpty) {
        _isVisible = false;
        items.clear();
      } else {
        if(text.length>3) {
          _isLoading=true;
          _search(text);
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
          brightness: Brightness.light,
          titleSpacing: 2.0,
          centerTitle: true,
          title: Row(
            children: <Widget>[
              Expanded(
                  child: TextFieldWidget(
                    color: Colors.white,
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
                            color: Colors.white,
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
                    icon: Icon(AppIcons.ic_scanner, color: Colors.white),
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
                  child: TextWidget(title:"No data available"),
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
    final item = items[index];
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Column(
          children: <Widget>[
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: getContent(item),
                    flex: 1,
                  ),
                  Expanded(
                    child: getImage(item),
                    flex: -1,
                  )
                ]),
            Divider(
              height: 25.0,
            ),
          ],
        ));
  }

  Widget getImage(SearchList item) {
    return Container(
        color: Colors.grey[100],
        width: 110.0,
        height: 90.0,
        child: ImageLoadWidget(imageUrl: item.ipath));
  }

  Widget getContent(SearchList item) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextWidget(title: item.pname, color: Colors.black, isBold: true),
          SizedBox(height: 5.0),
          TextWidget(
              title: item.pdesc,
              fontSize: 13.0,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          SizedBox(height: 5.0),
          ratingAndReview(item),
          SizedBox(height: 5.0),
          TextWidget(title: "mentioned in 0 reviews"),
        ],
      ),
    );
  }

  Widget ratingAndReview(SearchList item) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RatingWidget(rating: item.astar),
         // AddReviewWidget(data: [item['pid'], item['pname'], item['pdesc'], item['ipath']])
        ],
      ),
    );
  }

}