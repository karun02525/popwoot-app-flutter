import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popwoot/ui/shared/global.dart';
import 'package:popwoot/ui/widgets/theme.dart';
import 'package:popwoot/ui/widgets/button_widget.dart';
import 'package:popwoot/ui/widgets/text_widget.dart';
import 'package:popwoot/ui/widgets/textfield_widget.dart';

class CategoryAdds extends StatefulWidget {
  @override
  _CategoryAddsState createState() => _CategoryAddsState();
}

class _CategoryAddsState extends State<CategoryAdds> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  ScrollController _scrollController = new ScrollController();

  final editName = TextEditingController();
  final editDesc = TextEditingController();
  final editUrl = TextEditingController();

  Dio dio;
  List<File> _items = [];
  File _image;
  final picker = ImagePicker();
  bool isHide1 = true;
  bool isHide2 = false;
  var pickedFile;

  @override
  void initState() {
    super.initState();
    dio = Dio();
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


  void callApi() async{

  // debugger();



    //imagePaths.add(ArrayData.getUri());
    //imagePaths.add(ArrayData.getUri());

    List imageBytes = _image.readAsBytesSync();
    postApi(editName.text,editDesc.text,editUrl.text,_items) ;
    /*
    if (editName.text.isEmpty) {
      Global.toast("Please enter category Name");
    } else if (editDesc.text.isEmpty) {
      Global.toast("Please enter  category description");
    } else if (_items.length == 0) {
      Global.toast("Please upload at least one photo");
    } else {
      Global.toast("Ok.........");
      debugPrint("Name: " + editName.text);
      debugPrint("Desc: " + editDesc.text);
      debugPrint("Url: " + editUrl.text);

      postApi(editName.text,editDesc.text,editUrl.text,_items);

      _items.forEach((element) {
        debugPrint("URL Image Path: " + element.toString());
      });
    }*/
  }


  void postApi(String txtName,String txtDesc,String txtUrl, List<File> items) async {


    FormData formData = FormData.fromMap({
      "files": [
        await MultipartFile.fromFile(_items[0].path, filename: p.basename(_items[0].path)),
        await MultipartFile.fromFile(_items[1].path, filename: p.basename(_items[1].path)),
      ]
    });


    Map<String, String> requestHeaders = {
      'Content-type': 'multipart/form-data',
      'Accept': 'application/json',
      //'Accept': 'multipart/form-data',
      'authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI1ZWRmODEzZjRiOTRjZjFjZjA3MTg4ZTgiLCJzY29wZXMiOltdLCJleHAiOjE1OTIxNDMwODEsImlhdCI6MTU5MjEyNTA4MX0.Hvfx2Zo82LynMtE6k1HJHQFaBpf4MpwWm3kSJMjgWMzDhpybMWM9TT-_tH57IewpaAcG4Q7afwrelHvzdHNs6Q'
    };


    try {
      final response = await dio.post("http://192.168.0.104:8087/uploadMultipleFiles",data: formData,
          options: Options(headers: requestHeaders));

      if(response.statusCode==200){
      //  print(json.decode(response.body));
        debugPrint("data_res : Success..............");
        Global.toast('Ok');
      }
    } on DioError catch (e) {
      var errorMessage= jsonDecode(jsonEncode(e.response.data));
      var statusCode= e.response.statusCode;
      if(statusCode == 400){
        debugPrint("data_res 1: ${errorMessage['status']}");
        debugPrint("data_res 1: ${errorMessage['message']}");
      }else if(statusCode == 401){
        debugPrint("data_res 1: ${errorMessage['status']}");
        debugPrint("data_res 1: ${errorMessage['message']}");
      }else{
        print(e.message);
        print(e.request);
      }
    }
  }

  muti(File file) async{
    await MultipartFile.fromFile(file.path, filename:p.basename(file.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: 2.0,
          title: Text(
            "Add Category",
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
          TextWidget('Category Name'),
          TextFieldWidget(
              hintText: 'Enter category name',
              controller: editName),
          TextWidget('Category Description'),
          TextFieldWidget(
              minLine: 3,
              hintText: 'Enter category description',
              controller: editDesc),
          TextWidget('Category urls'),
          TextFieldWidget(
              hintText: 'Enter category urls',
              controller: editUrl),
          ButtonWidget(title: "Add Category",
            onPressed:callApi,
          ),SizedBox(height: 100.0,)

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
