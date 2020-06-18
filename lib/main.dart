import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/services/connectivity_service.dart';
import 'package:popwoot/src/main/ui/navigation/tab_nav_controller.dart';
import 'package:popwoot/src/main/ui/product/add_category.dart';
import 'package:popwoot/src/main/ui/product/add_product.dart';
import 'package:popwoot/src/main/ui/product/add_review.dart';
import 'package:popwoot/src/main/ui/product/global_search.dart';
import 'package:popwoot/src/res/colors.dart';
import 'package:provider/provider.dart';

void main() => runApp(LaunchApp());

class LaunchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider( create: (_) => ConnectivityService().connectionStatusController.stream,
      child:MaterialApp(
        theme: ThemeData(
            primaryColor: AppColor.appColor, accentColor: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: TabNavController(),
        routes: {
          '/home':(context) => TabNavController(),
          '/add_category':(context) => AddCategory(),
          '/add_product':(context) => AddProduct(),
          '/add_review':(context) => AddReview(),
          '/search':(context) => GlobalSearch()
        },
      ));
  }
}
