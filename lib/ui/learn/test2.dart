import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter Radio Button Group Example"),
          ),
          body: SafeArea(
              child : Center(

                child:RadioGroup(),

              )
          )
      ),
    );
  }
}

class RadioGroup extends StatefulWidget {
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class FruitsList {
  String name;
  int index;
  FruitsList({this.name, this.index});
}

class RadioGroupWidget extends State {

  // Default Radio Button Item
  String radioItem = 'Mango';

  // Group Value for Radio Button.
  int id = 1;

  List<FruitsList> fList = [
    FruitsList(
      index: 1,
      name: "Mango",
    ),
    FruitsList(
      index: 2,
      name: "Apple",
    ),
    FruitsList(
      index: 3,
      name: "Banana",
    ),
    FruitsList(
      index: 4,
      name: "Cherry",
    ),
  ];

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding : EdgeInsets.all(14.0),
            child: Text('$radioItem', style: TextStyle(fontSize: 23))
        ),

        Expanded(
            child: Container(
              height: 350.0,
              child: Column(
                children:
                fList.map((data) => RadioListTile(
                  title: Text("${data.name}"),
                  groupValue: id,
                  value: data.index,
                  onChanged: (val) {
                    setState(() {
                      radioItem = data.name ;
                      id = data.index;
                    });
                  },
                )).toList(),
              ),
            )),

      ],
    );
  }
}