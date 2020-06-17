import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/project/popwoot_project/popwoot/lib/ui/navigation/tabs/category.dart';
import 'file:///D:/project/popwoot_project/popwoot/lib/ui/navigation/tabs/home.dart';
import 'file:///D:/project/popwoot_project/popwoot/lib/ui/navigation/tabs/profile.dart';
import 'file:///D:/project/popwoot_project/popwoot/lib/ui/navigation/tabs/review.dart';
import 'file:///D:/project/popwoot_project/popwoot/lib/ui/navigation/tabs/scanner.dart';
import 'package:popwoot/ui/widgets/global.dart';

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
            icon: Icon(Global.ic_scanner),
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
