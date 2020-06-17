import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/utils/global.dart';

class DialogDemo extends StatefulWidget {
  @override
  _DialogDemoState createState() => _DialogDemoState();
}

class _DialogDemoState extends State<DialogDemo> {

  List<SelectCityModel> cityList;
  static int cityId=8;
  @override
  void initState() {
    super.initState();
    cityList = SelectCityModel.getCityList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
             title: Text("Dialog Demo"),
           ),
         body:  MaterialButton(
           elevation: 6.0,
           child: Text("Done"),
           onPressed: () {
             showDialog(context: context, builder: (_) {
                   return MyDialog(cityList);
                 }).then((value) => {
                  Global.toast(value.toString())
             });
           },
         )
    );
  }
}



class MyDialog extends StatefulWidget {
  final List<SelectCityModel> cityList;
  MyDialog(this.cityList);

  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  int selectId=_DialogDemoState.cityId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select City Name"),
      content: SingleChildScrollView(
        child:Container(
                child: Column(
                  children:
                  widget.cityList.map((data) => RadioListTile(
                   title: Text("${data.eng} (${data.hi} )"),
                    groupValue: selectId,
                    value: data.cid,
                    activeColor: Colors.blueAccent,
                    selected: selectId == data.cid,
                    onChanged: (val) {
                      setState(() {
                        debugPrint("select item: ${data.eng}");
                        selectId = data.cid;
                        debugPrint("select item selectId : $selectId");
                      });
                    },
                  )).toList(),
                ),
              ),
      ),
      actions: <Widget>[
        MaterialButton(
          elevation: 6.0,
          child: Text("Done"),
          onPressed: () {
            Navigator.of(context).pop(selectId);
          },
        )
      ],
    );
  }
}










class SelectCityModel{
  int cid;
  String eng;
  String hi;
  SelectCityModel({this.cid,this.eng,this.hi});

  static List<SelectCityModel> getCityList(){
    return [
      SelectCityModel(cid:1,eng:'Pusauli',hi:'पुसौली'),
      SelectCityModel(cid:2,eng:'Mohania',hi:'मोहनिया'),
      SelectCityModel(cid:3,eng:'Kudra',hi:'कुदरा'),
      SelectCityModel(cid:4,eng:'Bhabhua',hi:'भभुआ'),
      SelectCityModel(cid:5,eng:'Ramgarh',hi:'रामगढ'),
      SelectCityModel(cid:6,eng:'Nuaon',hi:'नुआओं'),
      SelectCityModel(cid:7,eng:'Durgawati',hi:'दुर्गावती'),
      SelectCityModel(cid:8,eng:'Chand',hi:'चाँद'),
      SelectCityModel(cid:9,eng:'Sonhan',hi:'सोनहन'),
    ];
  }
}

