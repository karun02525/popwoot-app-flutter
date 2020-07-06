import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:popwoot/src/main/api/repositories/add_product_repository.dart';
import 'package:popwoot/src/main/api/repositories/profile_repository.dart';
import 'package:popwoot/src/main/ui/navigation/drawer_navigation.dart';
import 'package:popwoot/src/main/ui/widgets/button_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/ui/widgets/textfield_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/fonts.dart';

class AddStore extends StatefulWidget {
  @override
  _AddStoreState createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  final editName = TextEditingController();
  final editDesc = TextEditingController();
  final editUrl = TextEditingController();

  AddProductRepository _repository;
  @override
  void initState() {
    super.initState();
    _repository = AddProductRepository(context);
     ProfileRepository(context).loginCheck();
  }


  void callApi() async {
    if (editName.text.isEmpty) {
      Global.toast("Please enter category Name");
    } else if (editDesc.text.isEmpty) {
      Global.toast("Please enter  category description");
    }  else {


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
                title: "Add Store",
                fontSize: AppFonts.toolbarSize,
                isBold: true)),
        drawer: NavigationDrawer(),
        body: SingleChildScrollView(
            child:getEditBox()));
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
            title: "Add Store",
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


}
