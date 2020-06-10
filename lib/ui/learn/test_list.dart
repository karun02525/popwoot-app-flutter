import 'dart:ffi';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/ui/shared/global.dart';
import 'package:popwoot/ui/widgets/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;

class TestListView extends StatefulWidget {
  @override
  _TestListViewState createState() => _TestListViewState();
}

class _TestListViewState extends State<TestListView> {
  Map data;
  List userData;
  var loading = true;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    callApi();
  }

  Future<Null> refreshList()  async {
    refreshKey.currentState.show();
    setState(() {
      callApi();
    });

  }


  Future callApi() async {
    var response = await http.get('https://jsonplaceholder.typicode.com/photos');
    if (response.statusCode == 200) {
      Global.toast("Reload.."+response.statusCode.toString());
      //data = convert.jsonDecode(response.body);
      setState(() {
        Global.toast("Reload.."+response.statusCode.toString());
        refreshKey.currentState.deactivate();
        userData = convert.jsonDecode(response.body);
        Global.toast("..  "+userData[1]['id'].toString());
      });

      debugPrint("Response: $userData");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 2.0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            letterSpacing: 1.0,
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            fontFamily: font,
          ),
        ),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return RefreshIndicator(
      onRefresh: refreshList,
      key: refreshKey,
      child: ListView.builder(
          itemCount: userData == null ? 0 : userData.length,
          itemBuilder: (context, index) => rowWidget(index)),
    );
  }

  Widget rowWidget(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(userData[index]['thumbnailUrl']),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "${userData[index]['userId']} ${userData[index]['id']} "),
            )
          ],
        ),
      ),
    );
  }
}
