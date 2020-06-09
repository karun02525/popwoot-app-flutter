import 'package:flutter/material.dart';
import 'package:popwoot/ui/navigation/drawer_navigation.dart';

import '../widgets/theme.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        titleSpacing: 2.0,
        title: Text(
          "Add Product",
          style: TextStyle(
            letterSpacing: 1.0,
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            fontFamily: font,
          ),
        ),
      ),
      drawer: NavigationDrawer(),
    );
  }
}
