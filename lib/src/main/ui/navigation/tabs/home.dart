import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popwoot/src/main/api/model/home_reviews_model.dart';
import 'package:popwoot/src/main/api/repositories/profile_repository.dart';
import 'package:popwoot/src/main/ui/widgets/home_widget.dart';
import 'package:popwoot/src/main/ui/widgets/search_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';

import '../drawer_navigation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<RevieswModel> revieswList=[];
  ProfileRepository _repository;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _repository = ProfileRepository(context);
    getReviewList();
  }

  void getReviewList() {
    _repository.findAllReview().then((value){
      setState(() {
        _isLoading = false;
        revieswList=value;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));

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
            : revieswList.length == 0
                ? Container(child: Center(child: TextWidget(title: 'No items available',)))
                : ListView.builder(
                    itemCount: null == revieswList ? 0 : revieswList.length,
                    itemBuilder: (context, index) =>
                        HomeWidget(items: revieswList, index: index)));
  }


}
