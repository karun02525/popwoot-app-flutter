import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/services/connectivity_service.dart';
import 'package:popwoot/ui/learn/api_pagination_list.dart';
import 'package:popwoot/ui/learn/call_api.dart';
import 'package:popwoot/ui/learn/dialog_demo.dart';
import 'package:popwoot/ui/product/add_category.dart';
import 'package:popwoot/ui/product/add_product.dart';
import 'package:popwoot/ui/shared/global.dart';
import 'file:///D:/project/popwoot_project/popwoot/lib/ui/navigation/tabs/tab_nav_controller.dart';
import 'package:provider/provider.dart';

void main() => runApp(LaunchApp());

class LaunchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider( create: (_) => ConnectivityService().connectionStatusController.stream,
      child:MaterialApp(
        theme: ThemeData(
            primaryColor: Global.appColor, accentColor: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: DialogDemo(),
        routes: {
          '/home':(context) => TabNavController(),
          '/add_category':(context) => AddCategory(),
          '/add_product':(context) => AddProduct()
        },
      ));
  }
}
