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
    _prefs.setString('name', value);
  }

  get name {
    return _prefs.getString('name');
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  get email {
    return _prefs.getString('email');
  }

  set avatar(String value) {
    _prefs.setString('avatar', value);
  }

  get avatar {
    return _prefs.getString('avatar');
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get token {
    return _prefs.getString('token') ?? '';
  }

  set isLogin(bool value) {
    _prefs.setBool('isLogin', value);
  }

  get isLogin {
    return _prefs.getBool('isLogin');
  }

  Future<bool> clearSharedPreferences() async {
    _prefs.clear();
    print("preferences clear");
    return true;
  }
}
