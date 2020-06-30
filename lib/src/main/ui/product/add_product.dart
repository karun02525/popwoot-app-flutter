import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popwoot/src/main/api/model/category_model.dart';
import 'package:popwoot/src/main/api/repositories/category_repository.dart';
import 'package:popwoot/src/main/api/repositories/product_repository.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/navigation/drawer_navigation.dart';
import 'package:popwoot/src/main/ui/widgets/button_widget.dart';
import 'package:popwoot/src/main/ui/widgets/dropdown_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/ui/widgets/textfield_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/app_icons.dart';
import 'package:popwoot/src/res/fonts.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  ScrollController _scrollController = new ScrollController();

  final editProdId = TextEditingController();
  final editProdName = TextEditingController();
  final editProdDesc = TextEditingController();
  final editProdSearchQ = TextEditingController();
  final editProdUrl = TextEditingController();
  String catId;

  String barcodeScanRes;

  List<File> _items = [];
  File _image;
  final picker = ImagePicker();
  var pickedFile;
  bool isHide1 = true;
  bool isHide2 = false;
  bool _isLoading=true;
  ProductRepository _repository;

  List<DataList> categoryList;
  CategoryRepository _catRepository;
  @override
  void initState() {
    super.initState();
    _repository = ProductRepository(context);
    _catRepository = CategoryRepository(context);
    getCategory();
  }


  void getCategory() {
    _catRepository.findAllCategory().then((value) {
        setState(() {
          _isLoading=false;
          categoryList=value;
        });
    });


  }
  Future scanBarcodeNormal() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.DEFAULT);
    setState(() {
      editProdId.text = barcodeScanRes;
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
    if (editProdId.text.isEmpty) {
      Global.toast("Please enter product id or scan");
    } else if (editProdName.text.isEmpty) {
      Global.toast("Please enter product name");
    } else if (catId==null) {
      Global.toast("Please select category");
    } else if (editProdDesc.text.isEmpty) {
      Global.toast("Please enter product description");
    } else if (editProdSearchQ.text.isEmpty) {
      Global.toast("Please enter product Search Query");
    }else if (editProdUrl.text.isEmpty) {
      Global.toast("Please enter product url");
    } else if (_items.length == 0) {
      Global.toast("Please upload at least one photo");
    } else {
      final imagesData = _items.map((item) =>
      Config.base64Prefix + base64Encode(item.readAsBytesSync())).toList();
      postApi(editProdId.text, editProdName.text,catId,editProdDesc.text,editProdSearchQ.text,editProdUrl.text, imagesData);
    }
  }

  void postApi(String prodId,String name,String catId,String desc,String searchQ,String prodUrl, List<String> imagesData) async {
    Map<String, dynamic> params = {
      'pcode':prodId,
      'pname':name,
      'category':catId,
      'pdescription':desc,
      'psearch':searchQ,
      'burl':prodUrl,
      'imgarray':imagesData,
    };

    _repository.addProduct(params).then((value) {
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
    editProdId.clear();
    editProdName.clear();
    catId=null;
    editProdDesc.clear();
    editProdSearchQ.clear();
    editProdUrl.clear();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        titleSpacing: 2.0,
        title: TextWidget(title: "Add Product", fontSize: AppFonts.toolbarSize,isBold: true),
      ),
      drawer: NavigationDrawer(),
        body: Stack(
          children: <Widget>[

            SingleChildScrollView(
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
                )),

            Center(
              child: Visibility(
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _isLoading,
                  child : CircularProgressIndicator()),
            )
          ],
        )
    );
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
              TextWidget(title: 'Add Photos', color: Colors.white,isBold: true,),
              RaisedButton.icon(
                onPressed: () => {_ImagePackerBtn(context)},
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
        onTap: () => {_ImagePackerBtn(context)},
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
                  TextWidget(title: 'Add Photos', color: Colors.white,isBold: true,)
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
          TextWidget(title:'Product ID or Scan',isBold: true,top: 15.0,bottom: 3.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 6,
                child:  TextFieldWidget(
                    hintText: 'Enter Product id',
                    controller: editProdId),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed:scanBarcodeNormal,
                  icon:Icon(AppIcons.ic_scanner),
                  iconSize: 40.0,
                ),
              )
            ],
          ),

          TextWidget(title:'Product Name',isBold: true,top: 15.0,bottom: 3.0),
          TextFieldWidget(
              hintText: 'Enter Product name',
              controller: editProdName),

          TextWidget(title:'Product Category',isBold: true,top: 15.0,bottom: 3.0),
          DropdownWidget(
            hint: 'Select category',
            value: catId,
            items: categoryList?.map((item) {
              return DropdownMenuItem(
                value: item.id??'',
                child: TextWidget(title:item.cname??''),
              );
            })?.toList(),
            onChanged: (newValue) {
              setState(() {
                catId = newValue;
              });
            },
          ),

          TextWidget(title:'Product Description',isBold: true,top: 15.0,bottom: 3.0),
          TextFieldWidget(
              minLine: 3,
              hintText: 'Enter Product description',
              controller: editProdDesc),

          TextWidget(title:'Product Search Query',isBold: true,top: 15.0,bottom: 3.0),
          TextFieldWidget(
              hintText: 'Enter Search Query',
              controller: editProdSearchQ),

          TextWidget(title:'Product urls',isBold: true,top: 15.0,bottom: 3.0),
          TextFieldWidget(
              hintText: 'Enter product urls',
              controller: editProdUrl),
          ButtonWidget(title: "Add Product",isBold: true,
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

  void _ImagePackerBtn(BuildContext context) {
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
