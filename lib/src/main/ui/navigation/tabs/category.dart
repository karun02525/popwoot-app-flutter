import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/category_model.dart';
import 'package:popwoot/src/main/api/repositories/category_repository.dart';
import 'package:popwoot/src/main/ui/product/product_list.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/search_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';

import '../drawer_navigation.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool _isLoading = true;
  bool isFollow = false;
  String follow = '';

  List<DataList> categoryList=[];
  CategoryRepository _catRepository;
  @override
  void initState() {
    super.initState();
    _catRepository = CategoryRepository(context);
    getCategory();
  }

  void getCategory() {
    _catRepository.findAllCategory().then((value) {
      setState(() {
        _isLoading = false;
        categoryList = value;
      });
    });
  }

  void doFlowingCall(String cid) {
    _isLoading = true;
    _catRepository.doFollow(cid).then((value) {
      setState(() {
        _isLoading = false;
        if (value) {
          getCategory();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 2.0,
        title: TextSearchWidget(),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          )
        ],
      ),
      drawer: NavigationDrawer(),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: ListView.builder(
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductList(),
                                  settings: RouteSettings(arguments: [
                                    categoryList[index].cname,
                                    categoryList[index].id
                                  ])));
                        },
                        child: buildCardView(context, index));
                  }),
            ),
    );
  }

  Widget buildCardView(BuildContext context, int index) {
    final i = categoryList[index];
    return Container(
        margin: EdgeInsets.only(left: 2, right: 5),
        child: Card(
          elevation: 3,
          child: ListTile(
            leading: SizedBox(
                width: 80.0, child: ImageLoadWidget(imageUrl: i.cimage)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextWidget(title: i.cname, isBold: true, fontSize: 12.0),
                FlatButton(
                    onPressed: () {
                      doFlowingCall(i.id);
                    },
                    child: i.follow == false
                        ? TextWidget(
                            title: 'Follow',
                            color: Colors.grey[400],
                            fontSize: 12.0)
                        : TextWidget(
                            title: 'Following',
                            color: Colors.lightBlue[400],
                            fontSize: 12.0))
              ],
            ),
            subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: TextWidget(title: i.cdetails)),
          ),
        ));
  }
}
