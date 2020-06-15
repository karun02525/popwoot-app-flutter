import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/product_add.dart';
import 'package:popwoot/services/connectivity_service.dart';
import 'package:popwoot/ui/product/add_category.dart';
import 'package:popwoot/ui/product/add_product.dart';
import 'package:provider/provider.dart';

import 'file:///D:/project/popwoot_project/popwoot/lib/ui/navigation/tabs/tab_nav_controller.dart';
import 'file:///D:/project/popwoot_project/popwoot/lib/ui/widgets/global.dart';

void main() => runApp(LaunchApp());

class LaunchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider( create: (_) => ConnectivityService().connectionStatusController.stream,
      child:MaterialApp(
        theme: ThemeData(
            primaryColor: Global.appColor, accentColor: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: ProductAdds(),
        routes: {
          '/home':(context) => TabNavController(),
          '/add_category':(context) => AddCategory(),
          '/add_product':(context) => AddProduct()
        },
      ));
  }
}
