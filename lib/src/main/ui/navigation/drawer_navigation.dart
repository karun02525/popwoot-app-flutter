import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/services/shared_preferences.dart';
import 'package:popwoot/src/main/utils/ip_address_shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String name, email, avatar;
  TextEditingController _editController = new TextEditingController();
  IpAddress ipAddress;
  @override
  void initState() {
    name=UserPreference().name;
    email=UserPreference().email;
    ipAddress=IpAddress();

    super.initState();
    setState(() {
      _editController.text =  ipAddress.ip;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Drawer(
      child: Wrap(

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
          CustomListTile(Icons.map, "Add Store ",
              () => {Navigator.pushNamed(context, '/add_store')}),
          Divider(color: Colors.grey),
          CustomListTile(Icons.star, "Ratings", () => {}),
          Divider(color: Colors.grey),
          CustomListTile(Icons.wb_sunny, "V0.0.1", () => {}),
          Divider(color: Colors.grey),
          CustomListTile(Icons.settings, "Setting", () => {_showDialog(context)}),
          Divider(color: Colors.grey),
        ],
      ),
    ));
  }


  Widget getInfo() {
    return Column(
      children: <Widget>[
        SizedBox(height: 25.0,),
        Text(
          name.toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: 22.0,),
        ),
        Text(
          email??'',
          style: TextStyle(color: Colors.white, fontSize: 13.0),
        ),
      ],
    );
  }

  _showDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                controller: _editController,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                    labelText: 'IP Address', hintText: 'Enter localhost ip',
                ),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('Submit'),
              onPressed: () {
                ipAddress.ip=_editController.text.toString().trim();
                Config.ipAdd=ipAddress.ip;
                Navigator.pop(context);
              })
        ],
      ),
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
