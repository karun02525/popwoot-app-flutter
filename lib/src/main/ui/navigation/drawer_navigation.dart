import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/services/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String name, email, avatar;

  @override
  void initState() {
    name=UserPreference().name;
    email=UserPreference().email;
    super.initState();
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
                children: <Widget>[getInfo()],
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
          CustomListTile(Icons.star, "Ratings", () => {}),
          Divider(color: Colors.grey),
          CustomListTile(Icons.wb_sunny, "V0.0.1", () => {}),
          Divider(color: Colors.grey),
        ],
      ),
    ));
  }


  Widget getInfo() {
    return Column(
      children: <Widget>[
        SizedBox(height: 50.0,),
        Text(
          name??'Guest User',
          style: TextStyle(color: Colors.white, fontSize: 22.0),
        ),
        Text(
          email??'',
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
