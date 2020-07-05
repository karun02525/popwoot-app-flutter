import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popwoot/src/main/api/repositories/add_product_repository.dart';
import 'package:popwoot/src/main/api/repositories/profile_repository.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:popwoot/src/main/ui/learn/audio_test.dart';
import 'package:popwoot/src/main/ui/navigation/tab_nav_controller.dart';
import 'package:popwoot/src/main/ui/product/review_details.dart';
import 'package:popwoot/src/main/ui/widgets/button_widget.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/rating_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/ui/widgets/textfield_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/fonts.dart';

class AddReview extends StatefulWidget {
  List<String> paramData;

  AddReview({Key key, this.paramData}) : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState(paramData);
}

class _AddReviewState extends State<AddReview> with WidgetsBindingObserver {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  ScrollController _scrollController = new ScrollController();

  final editComment = TextEditingController();
  final editYoutube = TextEditingController();
  String ratingValue = "0", pid, pname, pdesc, ipath, comment, astar;
  List<String> paramData;

  _AddReviewState(param) {
    this.paramData = param;

    pid = paramData[0];
    pname = paramData[1];
    pdesc = paramData[2];
    ipath = paramData[3];
    comment = paramData[4];
    astar = paramData[5];
  }

  List<File> _items = [];
  File _image;
  final picker = ImagePicker();
  bool isHide1 = true, isHide2 = false;
  var pickedFile;
  bool isCheckToken=false;
  ProfileRepository _rep;
  AddProductRepository _repository;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _repository = AddProductRepository(context);
    _rep = ProfileRepository(context);
    _rep.loginCheck();

    setState(() {
      if (comment != '') editComment.text = comment;

      if (astar != '') ratingValue = astar;
    });
  }

  Future _showPhotoLibrary(bool isCamera) async {
    if (isCamera) {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
        maxHeight: 720.0,
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
    if (editComment.text.isEmpty) {
      Global.toast("Please enter review");
    } /*else if (editYoutube.text.isEmpty) {
      Global.toast("Please enter youtube url");
    }*/
    else if (ratingValue == "0") {
      Global.toast("Please do at least one star");
    } else if (_items.length == 0) {
      Global.toast("Please upload at least one photo");
    } else {
      final imagesData = _items
          .map((item) =>
              Config.base64Prefix + base64Encode(item.readAsBytesSync()))
          .toList();

      postApi(editComment.text, editYoutube.text, imagesData, 1);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print(editComment.text);
      if (editComment.text.isNotEmpty) {
        Map<String, dynamic> draftParams = {
          'pid': pid,
          'pname': pname,
          'pdesc': pdesc,
          'astar': ratingValue,
          'ipath': ipath,
          'comment': editComment.text,
          'published': 0,
        };
        _repository.addReviewDraft(draftParams);
        Global.toast('Message saved as draft');
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void postApi(String comment, String youtubeurl, List<String> imagesData,
      published) async {
    Map<String, dynamic> param = {
      'pid': pid,
      'pname': pname,
      'pdesc': pdesc,
      'comment': comment,
      'astar': ratingValue,
      'published': published,
      'youtubeurl': youtubeurl,
      'audio': AppAudioTest.audio,
      'imgarray': imagesData,
    };

    _repository.addReview(param).then((value) {
      if (value) {
        Global.hideKeyboard();
        setState(() {
          _clearAllItems();
        });
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => TabNavController()));
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
    ratingValue = "0";
    editComment.clear();
    editYoutube.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 2.0,
          title: TextWidget(
              title: "Add Review",
              fontSize: AppFonts.toolbarSize,
              isBold: true),
        ),
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
            getRow(),
            getEditBox(),
          ],
        )));
  }

  Widget getRow() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10.0, right: 5.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getImage(),
            getContent(),
          ]),
    );
  }

  Widget getContent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ReviewDetails(pid: pid, pname: pname)));
                },
                child: TextWidget(
                  title: pname ?? 'N.A',
                  isBold: true,
                )),
            RatingWidget(
              rating: ratingValue,
              isDisable: true,
              onRatingUpdate: (value) {
                ratingValue = value.toString();
              },
            ),
            TextWidget(title: pdesc),
          ],
        ),
      ),
    );
  }

  Widget getImage() {
    return Container(
        color: Colors.grey[100],
        width: 110.0,
        height: 90.0,
        child: ImageLoadWidget(imageUrl: ipath));
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
          TextFieldWidget(
              hintText: 'Enter You Tube Url', controller: editYoutube),
          ButtonWidget(
            title: "Submit Review",
            isBold: true,
            onPressed: callApi,
          ),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget audioWidget() {
    return Row(
      children: <Widget>[
        TextWidget(title: "Like Audio Review-Start Recording", top: 0.0),
        IconButton(
          icon: Icon(
            Icons.mic,
            color: Colors.redAccent,
            size: 26.0,
          ),
          onPressed: () {},
        )
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
              TextWidget(
                title: 'Add Photos',
                color: Colors.white,
                isBold: true,
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
