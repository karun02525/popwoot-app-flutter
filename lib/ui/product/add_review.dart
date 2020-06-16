import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popwoot/constraints/constraints.dart';
import 'package:popwoot/ui/learn/audio_test.dart';
import 'package:popwoot/ui/navigation/drawer_navigation.dart';
import 'package:popwoot/ui/widgets/button_widget.dart';
import 'package:popwoot/ui/widgets/global.dart';
import 'package:popwoot/ui/widgets/text_widget.dart';
import 'package:popwoot/ui/widgets/textfield_widget.dart';
import 'package:popwoot/ui/widgets/theme.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../widgets/theme.dart';

class AddReview extends StatefulWidget {
  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  ScrollController _scrollController = new ScrollController();

  final editComment = TextEditingController();
  final editYoutube = TextEditingController();
  int ratingValue=0;
  ProgressDialog pd;

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
    pd = ProgressDialog(context, type: ProgressDialogType.Normal);
    pd.style(message: 'Uploading file...');
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
    if (editComment.text.isEmpty) {
      Global.toast("Please enter review");
    } else if (editYoutube.text.isEmpty) {
      Global.toast("Please enter youtube url");
    } else if (ratingValue == 0) {
      Global.toast("Please do at least one star");
    } else if (_items.length == 0) {
      Global.toast("Please upload at least one photo");
    } else {
      await pd.show();

      final imagesData = _items
          .map((item) =>
              Constraints.base64Prefix + base64Encode(item.readAsBytesSync()))
          .toList();

      postApi(editComment.text, editYoutube.text,AppAudioTest.audio,imagesData);
    }
  }

  void postApi(String comment,String youtubeurl,String audio,List<String> imagesData) async {
    Map<String, dynamic> params = {
      'pid': '5ee864ea50f66a2288a3193b',
      'pname': 'pname',
      'pdesc': 'pdesc',
      'comment': comment,
      'astar': ratingValue,
      'published': 1,
      'youtubeurl': youtubeurl,
      'audio': audio,
      'imgarray': imagesData,
    };

    debugPrint("print param: "+params.toString());

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer ${Constraints.token}'
    };

    try {
      final response = await dio.post(Constraints.addReviewUrl,
          data: params, options: Options(headers: requestHeaders));

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(jsonEncode(response.data));
        if (responseBody['status']) {
          pd.hide();
          messageAlert(responseBody['message'], 'Add Review');
        }
      }
    } on DioError catch (e) {
      var errorMessage = jsonDecode(jsonEncode(e.response.data));
      var statusCode = e.response.statusCode;
      if (statusCode == 400) {
        pd.hide();
        Global.toast(errorMessage['message']);
      } else if (statusCode == 401) {
        pd.hide();
        Global.toast(errorMessage['message']);
      } else {
        pd.hide();
        Global.toast('Something went wrong');
      }
    }
  }

  messageAlert(String msg, String ttl) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: CupertinoAlertDialog(
                title: Text(ttl),
                content: Text(msg),
                actions: <Widget>[
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Column(
                      children: <Widget>[Text('Okay')],
                    ),
                    onPressed: () {
                      setState(() {
                        _clearAllItems();
                      });
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
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
    ratingValue=0;
    editComment.clear();
    editYoutube.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: 2.0,
          title: Text(
            "Add Review",
            style: TextStyle(
              letterSpacing: 1.0,
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              fontFamily: font,
            ),
          ),
        ),
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

            Divider(
              height: 2.0,
              color: Colors.black,
            ),
            getRow(),
            Divider(
              height: 32.0,
              color: Colors.black,
            ),
             getEditBox(),
          ],
        )));
  }

  Widget getRow() {
    return Container(
      margin: EdgeInsets.only(top: 10,left: 10.0,right: 5.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getProductImage(
                'https://image3.mouthshut.com/images/imagesp/925748105s.jpg'),
            getContent("Vu televisions", "IE", 0, 0),
          ]),
    );
  }

  Widget getContent(String id, String title, int rating, int review) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextWidget(
              title: title,
              isBold: true,
              top: 0.0,
            ),
            setStar(rating),
            TextWidget(title: "Electronics", color: Colors.blue, top: 0.0),
            TextWidget(
                title: "product/f47e8686-b793-4763-8ffd-3f39d9a1f84f_0.png",
                top: 0.0),
          ],
        ),
      ),
    );
  }

  Widget getProductImage(String url) {
    return Container(
        width: 140.0,
        height: 100.0,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.fill,
        ));
  }

  Widget setStar(int rating) {
    return FlutterRatingBar(
      initialRating: rating.toDouble(),
      fillColor: Colors.amber,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      itemSize: 25.0,
      onRatingUpdate: (double rating) {
        ratingValue=rating.toInt();
      },
    );
  }

  Widget getEditBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFieldWidget(
              hintText: 'Tell us what you like or dislike about this product',
              minLine: 6,
              controller: editComment),
          SizedBox(height: 5.0),
          audioWidget(),
          SizedBox(height: 5.0),
          TextFieldWidget(hintText: 'Enter You Tube Url', controller: editYoutube),
          ButtonWidget(
            title: "Submit Review",
            isBold:true,
            onPressed: callApi,
          ),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }


  Widget audioWidget(){
     return Row(
        children: <Widget>[
          TextWidget(title: "Like Audio Review-Start Recording", top: 0.0),
          IconButton(icon: Icon(Icons.mic,color: Colors.redAccent,size: 26.0,),onPressed: (){},)
        ],
     );
  }




  //---------Add Remove--------
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
