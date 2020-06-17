import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/services/login_service.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/utils/connectivity_status.dart';
import 'package:popwoot/src/res/fonts.dart';
import 'package:provider/provider.dart';
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


  void _handleSignIn(){
    signInWithGoogle().whenComplete(() {
      setState(() {
        name = username;
        email =emailId;
        url = imageUrl;
        isLogin = true;
        setValues();
      });
    });
  }

  void _handleSignOut(){
    signOutGoogle();
    clearSharedPreferences();
  }


  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 2.0,
          centerTitle: true,
          title: TextWidget(title: "Category",fontSize:AppFonts.toolbarSize,isBold: true),
        ),
        body: Column(
          children: <Widget>[
            Text('Connection Status: $connectionStatus'),
            connectionStatus ==
                    ConnectivityStatus
                        .Wifi // Check status and show different buttons
                ? FlatButton(
                    child: Text('Sync Large files'),
                    color: Colors.blue[600],
                    onPressed: () {})
                : FlatButton(
                    child: Text('Turn on Cellular Sync'),
                    color: Colors.red[600],
                    onPressed: () {},
                  ),
            _buildInfo(),
          ],
        ));
  }

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
                  imageUrl: url,
                )),
            SizedBox(height: 30.0),
            TextWidget(title:  name.toUpperCase(),isBold: true,),
            TextWidget(title:email),
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
  }
}
