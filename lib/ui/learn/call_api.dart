import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/api/api_repository.dart';
import 'package:popwoot/api/model/post/post_model.dart';

class CallApi extends StatefulWidget {
  @override
  _CallApiState createState() => _CallApiState();
}

class _CallApiState extends State<CallApi> {
  var _apiRepository = ApiRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


     body: Container(
      child: FutureBuilder(
        future: _apiRepository.getPostApi,
        builder: (context,AsyncSnapshot<List<PostModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container(
                  child: Center(child: CircularProgressIndicator()));
              break;
            case ConnectionState.waiting:
              return Container(
                  child: Center(child: CircularProgressIndicator()));
              break;
            case ConnectionState.active:
              return Container(
                  child: Center(child: CircularProgressIndicator()));
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Container(child: Center(child: Text("Something wrong")));
              }else{
                return BuildList(listData: snapshot.data);
              }
              break;
          }
          return Container();
        },
      ),),
    );
  }
}

class BuildList extends StatelessWidget {
  const BuildList({
    Key key,
    this.listData
  }) : super (key: key);
  final List<PostModel> listData;
  @override
  Widget build(BuildContext context) {
    return Container(
          child: ListView.builder(
              itemCount: listData.length,
              itemBuilder: (context,index){
                return ListTile(
                  leading: Text(listData[index].title),
                );
              }
          ),

    );
  }
}
