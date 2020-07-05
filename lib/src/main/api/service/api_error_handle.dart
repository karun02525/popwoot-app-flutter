import 'dart:convert';

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
      Global.handleSignOut(context);
      return false;
    } else if (statusCode == 403) {
      Global.toast(errorMessage['message']);
      return false;
    } else if (statusCode == 404) {
      Global.toast(errorMessage['message']);
      return false;
    } else if (statusCode == 500) {
      Global.toast('Something went wrong please try again!!');
      return false;
    }else {
      Global.toast('Something went wrong');
      return false;
    }
  }

}