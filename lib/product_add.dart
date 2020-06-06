import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popwoot/ui/theme.dart';
import 'package:popwoot/ui/widgets/text_widget.dart';
import 'package:popwoot/ui/widgets/textfield_widget.dart';


class ProductAdds extends StatefulWidget {
  @override
  _ProductAddsState createState() => _ProductAddsState();
}

class _ProductAddsState extends State<ProductAdds> {

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });

}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {},
          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          icon: Icon(Icons.playlist_add),
          label: Text('Add Category'),
        ),
        appBar: AppBar(
          titleSpacing: 2.0,
          title: Text(
            "Add Product",
            style: TextStyle(
              letterSpacing: 1.0,
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              fontFamily: font,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            getAddListImage(),
            getEditBox(),
          ],
        )));
  }

  Widget getAddImage() {
    return Container(
      width: double.infinity,
      height: 150.0,
      child: Center(
        child: RaisedButton.icon(
          onPressed:getImage,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          label: Text(
            'Add Photos',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
          textColor: Colors.white,
          splashColor: Colors.red,
          color: Colors.lightBlue,
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:[Colors.deepOrange[300],Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      )
    );
  }

  Widget getAddListImage() {
    return Container(
        width: double.infinity,
        height: 150.0,
        child: Center(
          child:  _image == null
              ? getAddImage()
              : Image.file(_image),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:[Colors.deepOrange[300],Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        )
    );
  }

  Widget getEditBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextWidget('Category Name'),
          TextFieldWidget(
            hintText: 'Enter category name',
          ),
          TextWidget('Category Description'),
          TextFieldWidget(
            minLine: 3,
            hintText: 'Enter category description',
          ),
          TextWidget('Category urls'),
          TextFieldWidget(
            hintText: 'Enter category urls',
          ),
        ],
      ),
    );
  }
}
