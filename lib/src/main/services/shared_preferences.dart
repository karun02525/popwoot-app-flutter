import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {

  static final UserPreference _instance = UserPreference._ctor();

  factory UserPreference(){
    return _instance;
  }

  UserPreference._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //get y set name
  set name(String value) {
    _prefs.setString('name', value??'Guest User');
  }

  get name {
    return _prefs.getString('name')??'Guest User';
  }

  set email(String value) {
    _prefs.setString('email', value??'');
  }

  get email {
    return _prefs.getString('email')??'';
  }

  set avatar(String value) {
    _prefs.setString('avatar', value??'N.A');
  }

  get avatar {
    return _prefs.getString('avatar')??'N.A';
  }

  set token(String value) {
    _prefs.setString('token', value??'');
  }

  get token {
    return _prefs.getString('token')??'N.A';
  }

  set isLogin(bool value) {
    _prefs.setBool('isLogin', value??false);
  }

  get isLogin {
    return _prefs.getBool('isLogin')??false;
  }

  Future<bool> clearSharedPreferences() async {
    _prefs.clear();
    print("preferences clear");
    return true;
  }
}
