import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String name, email, url;

  Future<void> getValues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('username');
      if(name==null){
        name="Guest User";
      }

      email = preferences.getString('email');
      if(email==null){
        email="";
      }

      url = preferences.getString('url');
      if(url==null){
        url="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
      }

    });
  }

  @override
  void initState() {
    super.initState();
    getValues();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Drawer(
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              color: Theme.of(context).primaryColor,
              child: Center(
                  child: Column(
                children: <Widget>[getProfileImage(), getInfo()],
              ))),
          CustomListTile(Icons.home, "Home",
              () => {Navigator.pushNamed(context, '/home')}),
          Divider(color: Colors.grey),
          CustomListTile(Icons.add_circle_outline, "Add Category",
              () => {Navigator.pushNamed(context, '/add_category')}),
          Divider(color: Colors.grey),
          CustomListTile(Icons.playlist_add, "Add Product ",
              () => {Navigator.pushNamed(context, '/add_product')}),
          Divider(color: Colors.grey),
          CustomListTile(Icons.verified_user, "Security", () => {}),
          Divider(color: Colors.grey),
          CustomListTile(Icons.star, "Ratings", () => {}),
          Divider(color: Colors.grey),
          CustomListTile(Icons.wb_sunny, "Version", () => {}),
          Divider(color: Colors.grey),
        ],
      ),
    ));
  }

  Widget getProfileImage() {
    return Container(
      width: 120,
      height: 120,
      margin: EdgeInsets.only(top: 10.0, bottom: 10),
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
           shape: BoxShape.circle,
            //  borderRadius: BorderRadius.all(Radius.circular(70)),
              border: Border.all(width: 2,color: Colors.yellow,style: BorderStyle.solid),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        imageUrl: url,
      ),
    );
  }

  Widget getInfo() {
    return Column(
      children: <Widget>[
        Text(
          name.toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: 22.0),
        ),
        Text(
          email,
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ],
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 10, 8.0, 10),
      child: InkWell(
        splashColor: Colors.cyanAccent,
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(icon),
            SizedBox(width: 10.0),
            Text(
              text,
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
