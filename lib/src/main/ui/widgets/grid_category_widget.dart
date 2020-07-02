import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/category_model.dart';
import 'package:popwoot/src/main/ui/product/product_list.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';

import 'image_load_widget.dart';

class GridCategory extends StatelessWidget {
  final List<DataList> categoryList;
  GridCategory({this.categoryList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title(), Expanded(child: gridViewWidget())],
        )));
  }

  gridViewWidget() {
    return Container(
      margin: EdgeInsets.only(left: 5.0, right: 5.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: categoryList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0),
        itemBuilder: (BuildContext context, int index) {
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
              child: buildCardView(categoryList[index]));
        },
      ),
    );
  }

  buildCardView(DataList categoryList) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              width: double.infinity,
              height: 80.0,
              child: ImageLoadWidget(imageUrl: categoryList.cimage)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextWidget(
              title: categoryList.cname,
              fontSize: 14.0,
              isBold: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0, top: 10.0, bottom: 10.0),
      child: TextWidget(
        title: 'Browse by Category',
        isBold: true,
        fontSize: 18.0,
      ),
    );
  }
}
