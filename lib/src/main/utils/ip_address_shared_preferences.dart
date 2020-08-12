import 'package:shared_preferences/shared_preferences.dart';

class IpAddress {

  static final IpAddress _instance = IpAddress._ctor();

  factory IpAddress(){
    return _instance;
  }

  IpAddress._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  set ip(String value) {
    _prefs?.setString('ip', value??'127.168.0.1');
  }

  get ip {
    return _prefs?.getString('ip');
  }

}
