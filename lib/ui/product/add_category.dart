import 'package:flutter/material.dart';
import 'package:popwoot/ui/navigation/drawer_navigation.dart';

import '../theme.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        titleSpacing: 2.0,
        title: Text(
          "Add Category",
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
