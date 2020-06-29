import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/services/shared_preferences.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';


class ProfileWidget extends StatefulWidget {

  final Function handleSignOut;
  ProfileWidget({this.handleSignOut});

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  String name, email, avatar;
  @override
  void initState() {
    name=UserPreference().name;
    email=UserPreference().email;
    avatar=UserPreference().avatar;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          headerContainer(),
          SizedBox(
            height: 10.0,
          ),
          Divider(),
        ],
      ),
    );
  }


  Widget headerContainer() {
    return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            getProfileImage(avatar),
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
            title: name?? "",
            isBold: true,
            fontSize: 18.0,
          ),
          TextWidget(
            title: email?? "",
            isBold: true,
            fontSize: 12.0,
          ),
          SizedBox(
            height: 5.0,
          ),
          InkWell(
            onTap:widget.handleSignOut,
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
