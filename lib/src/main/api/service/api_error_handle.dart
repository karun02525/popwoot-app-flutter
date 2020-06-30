import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/services/google+login_service.dart';
import 'package:popwoot/src/main/services/shared_preferences.dart';
import 'package:popwoot/src/main/ui/navigation/tab_nav_controller.dart';
import 'package:popwoot/src/main/ui/navigation/tabs/profile.dart';
import 'package:popwoot/src/main/utils/global.dart';


class ApiErrorHandel{



 static bool errorHandel(context,e){
   dynamic errorMessage="";
    try {
      errorMessage = jsonDecode(jsonEncode(e.response.data));
    } catch (e) {
      Global.toast('Something went wrong');
      return false;
    }
    var statusCode = e.response.statusCode;
    if (statusCode == 400) {
      Global.toast(errorMessage['message']);
      return false;
    } else if (statusCode == 401) {
      Global.toast(errorMessage['message']);
      _handleSignOut(context);
      return false;
    } else if (statusCode == 403) {
      Global.toast(errorMessage['message']);
      return false;
    } else if (statusCode == 404) {
      Global.toast(errorMessage['message']);
      return false;
    } else {
      Global.toast('Something went wrong');
      return false;
    }
  }

 static void _handleSignOut(context) {
   signOutGoogle();
   UserPreference().clearSharedPreferences().then((value){
     if(value){
       Navigator.of(context).pushReplacement(
           MaterialPageRoute(
               builder: (BuildContext context) => TabNavController(pos: 4)
           )
       );
     }
   });
 }

}