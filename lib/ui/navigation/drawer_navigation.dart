import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child:Drawer(
          child:Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.0),
                  color: Theme.of(context).primaryColor,
                  child:Center(
                      child:Column(
                        children: <Widget>[
                          getProfileImage(),
                          getInfo()
                        ],
                      ))
              ),

              CustomListTile(Icons.home,"Home",()=>{Navigator.pushNamed(context, '/home')}),
              Divider(color: Colors.grey),
              CustomListTile(Icons.add_circle_outline,"Add Category",()=>{Navigator.pushNamed(context, '/add_category')}),
              Divider(color: Colors.grey),
              CustomListTile(Icons.playlist_add,"Add Product ",()=>{Navigator.pushNamed(context, '/add_product')}),
              Divider(color: Colors.grey),
              CustomListTile(Icons.verified_user,"Security",()=>{}),
              Divider(color: Colors.grey),
              CustomListTile(Icons.star,"Ratings",()=>{}),
              Divider(color: Colors.grey),
              CustomListTile(Icons.wb_sunny,"Version",()=>{}),
              Divider(color: Colors.grey),

            ],
          ),
        ));
  }
}

Widget getProfileImage(){
  return Container(
    width: 100,
    height: 80,
    margin: EdgeInsets.only(top: 30.0,bottom: 10),
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: NetworkImage('https://d3nt9em9l1urz8.cloudfront.net/media/catalog/product/cache/3/image/9df78eab33525d08d6e5fb8d27136e95/i/m/img_7414_1.jpg'),
            fit: BoxFit.fill
        )
    ),
  );
}

Widget getInfo(){
  return Column(
    children: <Widget>[
      Text("Ram Singh",style: TextStyle(color: Colors.white,fontSize: 22.0),),
      Text("ram@gmail.com",style: TextStyle(color: Colors.white,fontSize: 12.0),),
    ],
  );
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;
  CustomListTile(this.icon,this.text,this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 10, 8.0, 10),
      child: InkWell(
        splashColor: Colors.cyanAccent,
        onTap:onTap,
        child: Row(
          mainAxisAlignment:MainAxisAlignment.start,
          children: <Widget>[
            Icon(icon),
            SizedBox(width: 10.0),
            Text(text,style: TextStyle(fontSize: 20.0),)
          ],
        ),
      ),
    );
  }
}
