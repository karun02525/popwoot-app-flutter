import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popwoot/src/main/ui/model/CategoryModel.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/res/fonts.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
 final List<CategoryModel> items = fetchAllCategory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        title: TextWidget(title: "Category", color: Colors.black,fontSize:AppFonts.toolbarSize,isBold: true),
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
                TextWidget(
                  title:items[index].name,
                  isBold: true,
                  fontSize: 12.0),
                FlatButton.icon(
                  onPressed: () {},
                  splashColor: Colors.cyanAccent,
                  icon: Icon(Icons.open_in_new, color: Colors.grey[600],size: 17.0,),
                  label: TextWidget(
                    title:"Follow",
                        color: Colors.grey[400],
                        fontSize: 12.0,
                  )
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextWidget(
               title: items[index].desc)
            ),
          ),
        ));
  }
}
