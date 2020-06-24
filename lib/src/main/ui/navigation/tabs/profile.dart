import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/services/login_service.dart';
import 'package:popwoot/src/main/ui/widgets/button_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLogin = false;
  String name = "", email = "", url = "";

  Future<void> setValues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isLogin', true);
    preferences.setString('username', name);
    preferences.setString('email', email);
    preferences.setString('url', url);
    debugPrint("save data in SharedPreferences");
  }

  Future<void> getValues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      isLogin = preferences.getBool('isLogin');
      if (isLogin == null) {
        isLogin = false;
      }
      name = preferences.getString('username');
      email = preferences.getString('email');
      url = preferences.getString('url');
      debugPrint("Get Data : $name : $email : $url  $isLogin");
    });
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    debugPrint("preferences clear");
    setState(() {
      isLogin = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getValues();
  }

  void _handleSignIn() {
    signInWithGoogle().whenComplete(() {
      setState(() {
        name = username;
        email = emailId;
        url = imageUrl;
        isLogin = true;
        setValues();
      });
    });
  }

  void _handleSignOut() {
    signOutGoogle();
    clearSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: isLogin ? logedProfile() : doLogin());
  }

  Widget doLogin() {
    return Center(
      child: InkWell(
        onTap: _handleSignIn,
        child: Image.asset(
          'assets/images/googlesignin.png',
          width: 300.0,
          height: 170.0,
        ),
      ),
    );
  }

  Widget logedProfile() {
    return Column(
      children: [
        headerContainer(),
        SizedBox(
          height: 10.0,
        ),
        Divider()
      ],
    );
  }

  Widget headerContainer() {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        getProfileImage(url),
        setName(),
      ],
    ));
  }

  Widget setName() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      margin: EdgeInsets.only(left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15.0,
          ),
          TextWidget(
            title: name==null ?"":name,
            isBold: true,
            fontSize: 18.0,
          ),
          TextWidget(
            title: email==null ?"":email,
            isBold: true,
            fontSize: 12.0,
          ),
          SizedBox(
            height: 5.0,
          ),
          InkWell(
            onTap: _handleSignOut,
            splashColor: Colors.cyanAccent,
            child: TextWidget(
              title: 'Logout',
              isBold: true,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }

  Widget getProfileImage(String url) {
    return Container(
      width: 80,
      height: 80,
      margin: EdgeInsets.only(top: 10.0, left: 20.0),
      child: url == null
          ? placeHolder()
          : CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => placeHolder(),
              imageUrl: url,
            ),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: new Border.all(
          color: Colors.blue,
          width: 3.0,
        ),
      ),
    );
  }

  Widget placeHolder() {
    return ClipOval(
        child: Image(image: AssetImage('assets/images/user_icon.png')));
  }
}

/*

Widget _buildInfo() {
  if (isLogin) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 150.0,
              height: 150.0,
              child: CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: url==null?"":url,
              )),
          SizedBox(height: 30.0),
          TextWidget(title:name==null ?"":name,isBold: true,),
          TextWidget(title:email==null ?"":email),
          SizedBox(height: 30.0),
          RaisedButton(
            onPressed:_handleSignOut,
            child: Text('SignOut'),
          )
        ],
      ),
    );
  } else {
    return Center(
      child: InkWell(
        onTap: _handleSignIn,
        child: Image.asset(
          'assets/images/googlesignin.png',
          width: 300.0,
          height: 170.0,
        ),
      ),
    );
  }
}*/
