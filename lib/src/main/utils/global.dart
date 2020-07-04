
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:popwoot/src/main/services/google+login_service.dart';
import 'package:popwoot/src/main/services/shared_preferences.dart';
import 'package:popwoot/src/main/ui/navigation/tab_nav_controller.dart';

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

  static List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://lh3.googleusercontent.com/qIaAjodlsDEjewTG9mKYJz17su5I28f6AzL76tJ6ERexiq6VrqlE-dcLJTYWAPRHq1hzbKCwa2RuetEO4g=w1080-h608-p-no-v0',
    'https://www.yayskool.com/images/school/4192708paradise-children-academy-lalapur-kaimur.jpg',
    'https://images.ixigo.com/image/upload/hotel/c_fill,w_220,h_220/mohania-vihar-hotel-mohani-image-559e952be4b0ffb8fe44139f',
    'https://i.ytimg.com/vi/KcIMRQILEm8/maxresdefault.jpg',
    'https://media-cdn.tripadvisor.com/media/photo-s/09/d9/4b/0f/getlstd-property-photo.jpg',
  ];



}