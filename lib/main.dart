import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/product_add.dart';
import 'package:popwoot/ui/product/add_category.dart';
import 'package:popwoot/ui/product/add_product.dart';
import 'package:popwoot/ui/tabs/home.dart';
import 'package:popwoot/ui/tabs/tab_controller.dart';


import 'ui/splash.dart';

void main() {

  runApp(MaterialApp(
    theme: ThemeData(
        primaryColor: Color(0xffE25819), accentColor: Colors.blue),
    debugShowCheckedModeBanner: false,
    home: ProductAdds(),
    routes: {
      '/home':(context) => TabBottomController(),
      '/add_category':(context) => AddCategory(),
      '/add_product':(context) => AddProduct()
    },
  ));
}
