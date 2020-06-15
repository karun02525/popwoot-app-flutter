import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/api/api_repository.dart';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  ApiRepository _apiRepository;

  String selectValue;
  List listData=[
    'karun','ram','rishi','ummesh','sita'
  ];

  @override
  void initState() {
    super.initState();
    _apiRepository = ApiRepository();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
           title: Text("App"),
         ),
      body: Container(
        child: Center(
            child:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.only(left: 16.0,right: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 2.0),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: DropdownButton(
                  hint: Text('Select category'),
                  value: selectValue,
                  style: TextStyle(color: Colors.blueAccent),
                  elevation: 5,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36.0,
                  isExpanded: true,
                  items: listData.map((value){
                     return DropdownMenuItem(
                       value: value,
                       child: Text(value),
                     );
                  }).toList(),
                  onChanged: (newValue){
                    setState(() {
                      selectValue=newValue;
                    });
                  },
                ),
              ),
            )
        )
      ),
    );
  }
}
