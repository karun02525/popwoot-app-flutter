import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ui/splash.dart';

void main() {

  runApp(MaterialApp(
    theme: ThemeData(
        primaryColor: Color(0xffE25819), accentColor: Colors.blue),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
