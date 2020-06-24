import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/ui/navigation/tabs/category.dart';
import 'package:popwoot/src/main/ui/navigation/tabs/home.dart';
import 'package:popwoot/src/main/ui/navigation/tabs/profile.dart';
import 'package:popwoot/src/main/ui/navigation/tabs/review.dart';
import 'package:popwoot/src/main/ui/navigation/tabs/scanner.dart';
import 'package:popwoot/src/main/ui/widgets/search_widget.dart';
import 'package:popwoot/src/res/app_icons.dart';

import 'drawer_navigation.dart';

class TabNavController extends StatefulWidget {
  @override
  _TabNavControllerState createState() => _TabNavControllerState();
}

class _TabNavControllerState extends State<TabNavController> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    CategoryScreen(),
    Review(),
    Scanner(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add),
            title: Text("Category"),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            title: Text("Review"),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.ic_scanner),
            title: Text("Scanner"),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
