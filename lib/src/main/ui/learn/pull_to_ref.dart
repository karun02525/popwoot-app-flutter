import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shimmer/shimmer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pull to Refresh Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserListState();
  }
}

class _UserListState extends State<UserList> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  final String apiUrl = "https://randomuser.me/api/?results=20";
  var loading=true;

  List<dynamic> _users = [];

  void fetchUsers() async {
    var result = await http.get(apiUrl);
    setState(() {
      loading=false;
      _users = json.decode(result.body)['results'];
    });
  }

  String _name(dynamic user) {
    return user['name']['title'] +
        " " +
        user['name']['first'] +
        " " +
        user['name']['last'];
  }

  String _location(dynamic user) {
    return user['location']['country'];
  }

  String _age(dynamic user) {
    return "Age: " + user['dob']['age'].toString();
  }

  Widget _buildList() {
    return loading ? shimmerEfects() : RefreshIndicator(
      key: refreshKey,
      child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: _users.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            _users[index]['picture']['large'])),
                    title: Text(_name(_users[index])),
                    subtitle: Text(_location(_users[index])),
                    trailing: Text(_age(_users[index])),
                  )
                ],
              ),
            );
          }),
      onRefresh: _getData,
    );
  }

  Future<void> _getData() async {
    setState(() {
      loading=true;
      fetchUsers();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Container(
        child: _buildList(),
      ),
    );
  }

  Widget shimmerEfects(){
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
            baseColor: Colors.grey[700],
            highlightColor: Colors.grey[100]),
      );
  }
}
