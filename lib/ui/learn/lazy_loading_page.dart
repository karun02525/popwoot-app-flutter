import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LazyLoadingPage extends StatefulWidget {
  @override
  _LazyLoadingPageState createState() => _LazyLoadingPageState();
}

class _LazyLoadingPageState extends State<LazyLoadingPage> {
  ScrollController _scrollController = ScrollController();
  List myList = [];
  int _currentMax = 10;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    myList = List.generate(10, (index) => "Item : ${index + 1}");
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  _getMoreData() {
    for (int i = _currentMax; i < _currentMax + 10; i++) {
      myList.add("Item : ${i + 1}");
    }
    _currentMax = _currentMax + 10;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lazy Loading"),
      ),
      body: _loading == true
          ? Container(
              child: Center(
                child: Text("Loading..."),
              ),
            )
          : Container(
              child: myList.length == 0
                  ? Center(child: Text("No Data available"))
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: myList.length + 1,
                      itemExtent: 180,
                      itemBuilder: (context, index) {
                        if (index == myList.length) {
                          return CupertinoActivityIndicator();
                        }
                        return ListTile(
                          title: Text(myList[index]),
                        );
                      }),
            ),
    );
  }
}
