import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popwoot/ui/model/CategoryModel.dart';
import 'package:popwoot/ui/theme.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
 final List<CategoryModel> items = fetchAllCategory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: Colors.grey,

      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text(
          "Category",
          style: TextStyle(
              color: Colors.black,
              fontFamily: font,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => buildCardView(context, index)),
      ),
    );
  }

  Widget buildCardView(BuildContext context, int index) {
    return Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Card(
          elevation: 3,
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: items[index].url,fit: BoxFit.fill,),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  items[index].name,
                  style: TextStyle(fontFamily: font, fontWeight: FontWeight.w700, fontSize: 12.0),
                ),
                FlatButton.icon(
                  onPressed: () {},
                  splashColor: Colors.cyanAccent,
                  icon: Icon(Icons.open_in_new, color: Colors.grey[600],size: 17.0,),
                  label: Text(
                    "Follow",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12.0,
                        fontWeight: FontWeight.w100,
                        fontFamily: font),
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                items[index].desc,
                maxLines: 3,
                style: TextStyle(
                  fontFamily: font,
                  fontWeight: FontWeight.w100,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ));
  }
}
