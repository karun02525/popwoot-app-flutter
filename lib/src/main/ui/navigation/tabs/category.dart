import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/model/CategoryModel.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/fonts.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List categoryList;
  Dio dio;
  bool _isLoading=true;


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
  void hideLoader(){
    setState(() {
      _isLoading=false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        title: TextWidget(title: "Category", color: Colors.black,fontSize:AppFonts.toolbarSize,isBold: true),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: ListView.builder(
            itemCount: categoryList.length,
            itemBuilder: (context, index) => buildCardView(context, index)),
      ),
    );
  }

  Widget buildCardView(BuildContext context, int index) {
    return Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Card(
          elevation: 3,
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: Config.baseImageUrl+categoryList[index]['cimage'],fit: BoxFit.fill,),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextWidget(
                  title:categoryList[index]['cname'],
                  isBold: true,
                  fontSize: 12.0),

                FlatButton(
                  onPressed: (){},
                  child:TextWidget(title:'Follow',color: Colors.grey[400],fontSize: 12.0))
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextWidget(
               title: categoryList[index]['cdetails'])
            ),
          ),
        ));
  }
}
