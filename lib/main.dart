import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/services/connectivity_service.dart';
import 'package:popwoot/src/main/services/shared_preferences.dart';
import 'package:popwoot/src/main/ui/navigation/tab_nav_controller.dart';
import 'package:popwoot/src/main/ui/product/add_Store.dart';
import 'package:popwoot/src/main/ui/product/add_category.dart';
import 'package:popwoot/src/main/ui/product/add_product.dart';
import 'package:popwoot/src/main/ui/product/add_review.dart';
import 'package:popwoot/src/main/ui/product/global_search.dart';
import 'package:popwoot/src/res/colors.dart';
import 'package:provider/provider.dart';

import 'src/main/utils/ip_address_shared_preferences.dart';

void main() {
  if (Platform.isAndroid) {
    // Android-specific code
  } else if (Platform.isIOS) {
    // iOS-specific code
  } else {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  runApp(LaunchApp());
}

class LaunchApp extends StatefulWidget {
  @override
  _LaunchAppState createState() => _LaunchAppState();
}

class _LaunchAppState extends State<LaunchApp> {
  @override
  void initState() {
    m();
    m2();
    super.initState();
  }

  void m() async {
    WidgetsFlutterBinding.ensureInitialized();
    await UserPreference().init();
  }
  void m2() async {
    WidgetsFlutterBinding.ensureInitialized();
    await IpAddress().init();
  }

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
        create: (_) => ConnectivityService().connectionStatusController.stream,
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: AppColor.appColor, accentColor: Colors.blue),
          debugShowCheckedModeBanner: false,
          home: TabNavController(),
          navigatorKey: navigatorKey,
          routes: {
            '/home': (context) => TabNavController(),
            '/add_category': (context) => AddCategory(),
            '/add_product': (context) => AddProduct(),
            '/add_review': (context) => AddReview(),
            '/add_store': (context) => AddStore(),
            '/search': (context) => GlobalSearch()
          },
        ));
  }
}
