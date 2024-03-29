import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popwoot/src/main/api/repositories/add_product_repository.dart';
import 'package:popwoot/src/main/api/repositories/profile_repository.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/navigation/drawer_navigation.dart';
import 'package:popwoot/src/main/ui/widgets/button_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/ui/widgets/textfield_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/fonts.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  ScrollController _scrollController = new ScrollController();

  final editName = TextEditingController();
  final editDesc = TextEditingController();
  final editUrl = TextEditingController();

  List<File> _items = [];
  File _image;
  final picker = ImagePicker();
  bool isHide1 = true;
  bool isHide2 = false;
  var pickedFile;

  AddProductRepository _repository;
  @override
  void initState() {
    super.initState();
    _repository = AddProductRepository(context);
     ProfileRepository(context).loginCheck();
  }

  Future _showPhotoLibrary(bool isCamera) async {
    if (isCamera) {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
        maxHeight: 1062.0,
        maxWidth: 1500.0,
      );
    } else {
      pickedFile = await picker.getImage(
          source: ImageSource.gallery, maxHeight: 1062.0, maxWidth: 1500.0);
    }
    setState(() {
      _image = File(pickedFile.path);
      _addItem(_items);
    });
  }

  void callApi() async {
    //debugger();
    if (editName.text.isEmpty) {
      Global.toast("Please enter category Name");
    } else if (editDesc.text.isEmpty) {
      Global.toast("Please enter  category description");
    } else if (_items.length == 0) {
      Global.toast("Please upload at least one photo");
    } else {
      final imagesData = _items
          .map((item) =>
              Config.base64Prefix + base64Encode(item.readAsBytesSync()))
          .toList();
      postApi(editName.text, editDesc.text, editUrl.text, imagesData);
    }
  }

  void postApi(String txtName, String txtDesc, String txtUrl,
      List<String> imagesData) async {
    Map<String, dynamic> params = {
      'cname': txtName,
      'cdetails': txtDesc,
      'burl': txtUrl,
      'imgarray': imagesData,
    };
    _repository.addCategory(params).then((value) {
      if (value) {
         Global.hideKeyboard();
         setState(() {
           _clearAllItems();
         });
      }
    });
  }

  void _clearAllItems() {
    for (var i = 0; i <= _items.length - 1; i++) {
      _key.currentState.removeItem(0,
          (BuildContext context, Animation<double> animation) {
        return Container();
      });
    }
    _items.clear();
    isHide1 = true;
    isHide2 = false;
    editName.clear();
    editDesc.clear();
    editUrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            titleSpacing: 2.0,
            title: TextWidget(
                title: "Add Category",
                fontSize: AppFonts.toolbarSize,
                isBold: true)),
        drawer: NavigationDrawer(),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Visibility(
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: isHide1,
                child: uploadPlaceHolderImage()),
            Visibility(
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: isHide2,
                child: uploadImage()),
            getEditBox(),
          ],
        )));
  }

  Widget uploadImage() {
    return Container(
        width: double.infinity,
        height: 150.0,
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
        height: 150.0,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextWidget(title: "Add Photos", isBold: true),
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
                color: Colors.grey[500],
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
              TextWidget(
                title: 'Add Photos',
                color: Colors.white,
                isBold: true,
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
          TextWidget(
              title: 'Category Name', isBold: true, top: 15.0, bottom: 3.0),
          TextFieldWidget(
              hintText: 'Enter category name', controller: editName),
          TextWidget(
              title: 'Category Description',
              isBold: true,
              top: 15.0,
              bottom: 3.0),
          TextFieldWidget(
              minLine: 3,
              hintText: 'Enter category description',
              controller: editDesc),
          TextWidget(
              title: 'Category urls', isBold: true, top: 15.0, bottom: 3.0),
          TextFieldWidget(hintText: 'Enter category urls', controller: editUrl),
          ButtonWidget(
            title: "Add Category",
            isBold: true,
            onPressed: callApi,
          ),
          SizedBox(
            height: 100.0,
          )
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

      if (_items.length > 0) {
        isHide1 = false;
        isHide2 = true;
      } else {
        isHide1 = true;
        isHide2 = false;
      }
    });
  }

  void _addItem(_items) {
    setState(() {
      int i = _items.length > 0 ? _items.length : 0;
      _items.add(_image);
      _key.currentState.insertItem(i);
      if (_items.length > 0) {
        isHide1 = false;
        isHide2 = true;
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
