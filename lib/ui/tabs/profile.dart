import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:popwoot/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';



GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['profile','email']
);

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLogin=false;
  String name="",email="",url="";

  Future<void>  setValues() async{
       SharedPreferences  preferences =await SharedPreferences.getInstance();
       preferences.setBool('isLogin', true);
       preferences.setString('username', name);
       preferences.setString('email', email);
       preferences.setString('url', url);
       debugPrint("save data in SharedPreferences");
  }

  Future<void>  getValues() async{
       SharedPreferences  preferences =await SharedPreferences.getInstance();
       setState(() {
         isLogin=preferences.getBool('isLogin');
         if(isLogin==null) {
             isLogin=false;
         }
         name=preferences.getString('username');
         email=preferences.getString('email');
         url=preferences.getString('url');
         debugPrint("Get Data : $name : $email : $url  $isLogin");
       });

  }
  Future<void> clearSharedPreferences() async{
       SharedPreferences  preferences =await SharedPreferences.getInstance();
       preferences.clear();
       debugPrint("preferences clear");
       setState(() {
         isLogin = false;
       });
  }


  @override
  void initState() {
    super.initState();
   _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
     setState(() {
         name= account.displayName;
         email= account.email;
         url= account.photoUrl;
         isLogin=true;
         setValues() ;
     });

   });
    getValues();
    _googleSignIn.signInSilently();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 2.0,
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(
              letterSpacing: 1.0,
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              fontFamily: font,
            ),
          ),
        ),
        body: _buildInfo()
    );
  }

  Widget _buildInfo(){
    if(isLogin){
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
                       image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                     ),
                   ),
                   placeholder: (context, url) => CircularProgressIndicator(),
                   imageUrl: url,
                 )),

                SizedBox(height: 30.0),
                Text(name.toUpperCase(),style: TextStyle(fontWeight: FontWeight.w700,fontFamily: font),),
                Text(email,style: TextStyle(fontWeight: FontWeight.w100,fontFamily: font),),
             SizedBox(height: 30.0),
             RaisedButton(
               onPressed: _handleSignOut,
               child: Text('SignOut'),
             )
           ],
         ),
       );
    }else{
       return Center(
               child:InkWell(
                 onTap: _handleSignIn,
                   child: Image.asset('assets/images/googlesignin.png',
                   width: 300.0,
                     height: 170.0,
                   ),

               ),
           );
    }
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.disconnect();
      clearSharedPreferences();
    } catch (e) {
      print(e);
    }
  }
}

