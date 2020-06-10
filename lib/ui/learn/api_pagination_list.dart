import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LazyLoadingPage extends StatefulWidget {
  @override
  _LazyLoadingPageState createState() => _LazyLoadingPageState();
}

class _LazyLoadingPageState extends State<LazyLoadingPage> {

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  static int page = 0;
  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  bool firstLoading = true;
  List users = List();
  final dio = Dio();

  @override
  void initState() {
    _callApi();
    super.initState();
  }

  _callApi(){
    this._getMoreData(page);
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        _getMoreData(page);
      }
    });
  }


  Future<void> _onRefresh() async {
    setState(() {
      page = 0;
      users.clear();
      firstLoading = true;
      _callApi();
    });

  }

  void _getMoreData(int index) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var url = "https://randomuser.me/api/?page=" + index.toString() + "&results=10";
      debugPrint("url : "+ url);
      final response = await dio.get(url);
      List tList = new List();
      for (int i = 0; i<response.data['results'].length; i++) {
        setState(() {
          debugPrint("Data : " + response.data['results'][i].toString());
          tList.add(response.data['results'][i]);
        });
      }

      setState(() {
        firstLoading=false;
        isLoading = false;
        users.addAll(tList);
        page++;
      });
    }
  }


  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lazy Load Large List"),
      ),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildList() {
    return firstLoading ? shimmerEffect() :
    RefreshIndicator(
        key: refreshKey,
        onRefresh: _onRefresh,
        child: users.length == 0
        ? Container(child: Center(child: Text('No data available')))
        : ListView.builder(
      itemCount: users.length + 1,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      controller: _sc,
      itemBuilder: (context,index) {
        if (index == users.length) {
          return _buildProgressIndicator();
        } else {
          return new ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                users[index]['picture']['large'],
              ),
            ),
            title: Text((users[index]['name']['first'])),
            subtitle: Text((users[index]['email'])),
          );
        }
      },
    ));
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }

  Widget shimmerEffect(){
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Shimmer.fromColors(

          direction: ShimmerDirection.ltr,
          period: Duration(seconds:2),
          child: Column(
            children: [0, 1, 2, 3,4,5,6,7,8]
                .map((_) => Padding(
              padding: const EdgeInsets.only(bottom: 5.0,top: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                  ),
                  Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10.0)),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 3.0),
                        ),
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 4.0),
                        ),
                        Container(
                          width: 40.0,
                          height: 8.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))
                .toList(),
          ),
          baseColor: Colors.grey[600],
          highlightColor: Colors.white),
    );
  }
}