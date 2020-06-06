import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/ui/tabs/category.dart';
import 'package:popwoot/ui/tabs/home.dart';
import 'package:popwoot/ui/tabs/profile.dart';
import 'package:popwoot/ui/tabs/review.dart';
import 'package:popwoot/ui/tabs/scanner.dart';

class TabBottomController extends StatefulWidget {
  @override
  _TabBottomControllerState createState() => _TabBottomControllerState();
}

class _TabBottomControllerState extends State<TabBottomController> {
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
            icon: Icon(Icons.center_focus_strong),
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
