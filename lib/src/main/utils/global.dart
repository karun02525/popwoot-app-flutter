
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:popwoot/src/main/services/google+login_service.dart';
import 'package:popwoot/src/main/services/shared_preferences.dart';
import 'package:popwoot/src/main/ui/navigation/tab_nav_controller.dart';
import 'package:popwoot/src/main/ui/notifications/tab_notification.dart';

class Global {


  static void toast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static void hideKeyboard(){
    FocusManager.instance.primaryFocus.unfocus();
  }

  static void snackBar(BuildContext context,String message){
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(message==null ? '---':message)));
  }

  static void showSnackBar(BuildContext context,String message){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Show Snackbar'),
      duration: Duration(seconds: 3),
    ));
  }


  static void handleSignOut(context) {
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


  static void naviNotification(context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) => TabNotificationScreen()
        )
    );
  }


  static String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    if (diff.inDays > 0)
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    if (diff.inHours > 0)
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    return "just now";
  }


}