import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'file:///D:/project/popwoot_project/popwoot/lib/ui/widgets/global.dart';
import 'package:popwoot/ui/widgets/theme.dart';
import 'package:popwoot/ui/widgets/button_widget.dart';
import 'package:popwoot/ui/widgets/text_widget.dart';
import 'package:popwoot/ui/widgets/textfield_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


class ProductAdds extends StatefulWidget {
  @override
  _ProductAddsState createState() => _ProductAddsState();
}

class _ProductAddsState extends State<ProductAdds> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  ScrollController _scrollController = new ScrollController();

  final productId = TextEditingController();
  final productName = TextEditingController();
  final productDesc = TextEditingController();

  String barcodeScanRes;

  List<File> _items = [];
  File _image;
  final picker = ImagePicker();
  var pickedFile;
  bool isHide1 = true;
  bool isHide2 = false;








  Future scanBarcodeNormal() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.DEFAULT);
    setState(() {
      productId.text = barcodeScanRes;
    });
  }

  Future _showPhotoLibrary(bool isCamera) async {
    if (isCamera) {
      pickedFile = await picker.getImage(
          source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
    } else {
      pickedFile = await picker.getImage(
          source: ImageSource.gallery, maxHeight: 480, maxWidth: 640);
    }
    setState(() {
      _image = File(pickedFile.path);
      _addItem(_items);
    });
  }


  void callApi(){

    if (productId.text.isEmpty) {
      Global.toast("Please enter category Name");
    } else if (productName.text.isEmpty) {
      Global.toast("Please enter  category description");
    } else if (_items.length == 0) {
      Global.toast("Please upload at least one photo");
    } else {
      Global.toast("Ok.........");
      _items.forEach((element) {
        debugPrint("URL Image Path: " + element.toString());
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
              Visibility(
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: isHide1,
                child : uploadPlaceHolderImage()),
            Visibility(
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: isHide2,
                child : uploadImage()),

            getEditBox(),
          ],
        )));
  }

  Widget uploadImage() {
    return Container(
        width: double.infinity,
        height: 130.0,
        child: Row(children: <Widget>[
          addGestureDetector(),
          Expanded(child: getListImage())
        ]),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.deepOrange[300], Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )));
  }

  Widget uploadPlaceHolderImage() {
    return Container(
        width: double.infinity,
        height: 130.0,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Add Photos",
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: font,
                    fontWeight: FontWeight.w700),
              ),
              RaisedButton.icon(
                onPressed: () => {_showOptions(context)},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                label: Text(
                  'Photos  ',
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
            ],
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.deepOrange[300], Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )));
  }

  Widget addGestureDetector() {
    return GestureDetector(
        onTap: () => {_showOptions(context)},
        child: Container(
          margin: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          width: 120.0,
          height: 120.0,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add_a_photo,
                size: 32.0,
                color: Colors.white,
              ),
              Text(
                'Add Photos',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: font),
              )
            ],
          )),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueAccent,
            ),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              new BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                  offset: new Offset(1.0, 1.0))
            ],
          ),
        ));
  }

  Widget getListImage() {
    return AnimatedList(
        scrollDirection: Axis.horizontal,
        key: _key,
        controller: _scrollController,
        shrinkWrap: true,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return GestureDetector(
              onTap: () {
                zoomImage(_items[index]);
              },
              child: _buildItem(_items[index], animation, index));
        });
  }

  Widget getEditBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextWidget('Product ID or Scan'),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Expanded(
               flex: 6,
             child:  TextFieldWidget(
                 hintText: 'Enter Product id',
                 controller: productId),
             ),
             Expanded(
               flex: 1,
               child: IconButton(
                   onPressed:scanBarcodeNormal,
                   icon:Icon(Global.ic_scanner),
                   iconSize: 40.0,
               ),
             )
           ],
          ),

          TextWidget('Product Name'),
          TextFieldWidget(
              hintText: 'Enter Product name',
              controller: productName),

          TextWidget('Product Category'),
          TextFieldWidget(
              hintText: 'Select product category',
              controller: productDesc),

          TextWidget('Product Description'),
          TextFieldWidget(
              minLine: 3,
              hintText: 'Enter Product description',
              controller: productDesc),

          TextWidget('Product Search Query'),
          TextFieldWidget(
              hintText: 'Enter Search Query',
              controller: productDesc),

          TextWidget('Product urls'),
          TextFieldWidget(
              hintText: 'Enter product urls',
              controller: productDesc),
          ButtonWidget(title: "Add Product",
             onPressed:callApi,
          ),
          SizedBox(height: 10.0,)
        ],
      ),
    );
  }

  //-----------------
  Widget _buildItem(File item, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.horizontal,
      child: Center(
        child: Container(
          margin: EdgeInsets.all(8.0),
          width: 120.0,
          height: 120.0,
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                removeItem(index);
              },
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
            ),
          ),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueAccent,
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                    offset: new Offset(1.0, 1.0))
              ],
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: item == null ? Text("") : FileImage(item))),
        ),
      ),
    );
  }

  void removeItem(int index) {
    setState(() {
      File removeItem = _items.removeAt(index);
      AnimatedListRemovedItemBuilder builder = (context, animation) {
        return _buildItem(removeItem, animation, index);
      };
      _key.currentState.removeItem(index, builder);

      if(_items.length>0) {
        isHide1 = false;
        isHide2=true;
      }else {
        isHide1 = true;
        isHide2=false;
      }
    });
  }

  void _addItem(_items) {
    setState(() {
      int i = _items.length > 0 ? _items.length : 0;
      _items.add(_image);
      _key.currentState.insertItem(i);
      if(_items.length>0) {
        isHide1 = false;
        isHide2=true;
      }
    });
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 1500), curve: Curves.easeOut);


  }

  void _showOptions(BuildContext context) {
    if (_items.length > 4) {
      Global.toast("You can not upload more than 5 photos.");
    } else {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                height: 150,
                child: Column(children: <Widget>[
                  ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        _showPhotoLibrary(true);
                      },
                      leading: Icon(Icons.photo_camera),
                      title: Text("Take a picture from camera")),
                  ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        _showPhotoLibrary(false);
                      },
                      leading: Icon(Icons.photo_library),
                      title: Text("Choose from photo library"))
                ]));
          });
    }
  }

  void zoomImage(File list) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 900),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
              // width: MediaQuery.of(context).size.width - 40,
              // height: MediaQuery.of(context).size.height -  230,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: const Color(0xFF1BC0C5),
                    ),
                  ),
                  Expanded(child: Image.file(list)),
                ],
              ),
            ),
          );
        });
  }
}
