import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/ui/widgets/search_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';

import '../drawer_navigation.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
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
        body: emptyScreen());
  }

  Widget emptyScreen() {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 100.0),
          Image.asset(
            'assets/images/empty_review.jpg',
          ),
          SizedBox(height: 10.0),
          TextWidget(title: 'Search some products',),
        ],
      ),
    );
  }
}
