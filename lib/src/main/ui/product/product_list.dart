import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/products_model.dart';
import 'package:popwoot/src/main/api/repositories/product_repository.dart';
import 'package:popwoot/src/main/ui/widgets/add_review_widget.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/res/fonts.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ProductListData> productList = [];
  bool _isLoading = true;
  ProductRepository _repository;


  @override
  void initState() {
    super.initState();
    _repository=ProductRepository(context);
  }


  void getOnlyProducts(String cid){
    _repository.findAllProducts(cid).then((value) {
      setState(() {
        _isLoading = false;
        productList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List data = ModalRoute.of(context).settings.arguments;
    getOnlyProducts(data[1]??'0');

    return Scaffold(
      appBar: AppBar(
          titleSpacing: 2.0,
          title: TextWidget(
              title: data[0], fontSize: AppFonts.toolbarSize, isBold: true)),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : productList.length == 0
              ? Container(
                  child: Center(
                  child: TextWidget(title: "No data available"),
                ))
              : Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (context, index) =>
                          buildCardView(context,productList[index])),
                ),
    );
  }

  Widget buildCardView(BuildContext context, ProductListData item) {
    return Container(
        margin: EdgeInsets.only(left: 2, right: 5),
        child: Card(
          elevation: 3,
          child: ListTile(
            leading: SizedBox(
                width: 80.0, child: ImageLoadWidget(imageUrl: item.avatar)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextWidget(title: item.pname??'', isBold: true, fontSize: 14.0),
                AddReviewWidget(data: {
                  "pid": item.pid??'0',
                  "pname": item.pname??'',
                  "pdesc": item.pdesc??'',
                  "ipath": item.avatar,
                }),
              ],
            ),
            subtitle: Padding(
                padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                child: TextWidget(title: item.pdesc, fontSize: 12.0)),
          ),
        ));
  }
}
