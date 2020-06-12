import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/project/popwoot_project/popwoot/lib/ui/navigation/tabs/tab_nav_controller.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => _navigateToHome());
  }


  void _navigateToHome(){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => TabNavController()
        )
      );
  }

 /* void _navigateToLogin(){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => NavigationTab()
        )
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color(0xffE25819),
        body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Container(
                margin: EdgeInsets.only(top: 260.0,left: 35.0,right: 20),
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor:Colors.yellow,
                  child: Text(
                    "PopWoot",
                    style: TextStyle(
                      fontSize: 70.0,
                      decoration: TextDecoration.none,
                      shadows: <Shadow>[
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.white,
                          offset: Offset.fromDirection(100,3)
                        )
                      ]
                      )
                    ),
                  ),
              ),

          decoration: BoxDecoration(
             gradient: LinearGradient(colors: [Colors.cyan,Colors.purpleAccent])
          ),
      ),
    );
  }
}
