import 'package:flutter/material.dart';
import 'file:///D:/project/popwoot_project/popwoot/lib/ui/widgets/global.dart';

class ShowSelectRadio extends StatefulWidget {
  @override
  ShowSelectRadioState createState() {
    return new ShowSelectRadioState();
  }
}

class ShowSelectRadioState extends State<ShowSelectRadio> {
  List<SelectCityModel> cityList;
  int _selectedItem = 3;

  @override
  void initState() {
    super.initState();
    cityList = SelectCityModel.getCityList();
  }

  selectItem(index) {
    setState(() {
      _selectedItem = index;
      Global.toast(cityList[index].hi);
      print(selectItem.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text("ok"),
        onPressed: () {
          createAlertDialog(context, cityList, selectItem, _selectedItem);
        },
      ),
    );
  }
}

Future<String> createAlertDialog(BuildContext context,
    List<SelectCityModel> cityList, selectItem, _selectedItem) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select City Name"),
          content: Container(
              child: ListView.builder(
            shrinkWrap: true,
            itemCount: cityList.length,
            itemBuilder: (context, index) {
              return CustomItem(
                selectItem,
                index: index,
                isSelected: _selectedItem == index ? true : false,
                title: cityList[index].eng,
              );
            },
          )),
          actions: <Widget>[
            MaterialButton(
              elevation: 6.0,
              child: Text("Done"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

class CustomItem extends StatefulWidget {
  final String title;
  final int index;
  final bool isSelected;
  Function(int) selectItem;
  CustomItem(
    this.selectItem, {
    Key key,
    this.title,
    this.index,
    this.isSelected,
  }) : super(key: key);
  _CustomItemState createState() => _CustomItemState();
}

class _CustomItemState extends State<CustomItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.selectItem(widget.index);
        },
        child: Row(
          children: <Widget>[
            widget.isSelected
                ? Icon(Icons.radio_button_checked)
                : Icon(Icons.radio_button_unchecked),
            Text("${widget.title}"),
          ],
        ));
  }
}

class SelectCityModel {
  int id;
  String eng;
  String hi;
  SelectCityModel({this.id, this.eng, this.hi});

  static List<SelectCityModel> getCityList() {
    return [
      SelectCityModel(id: 1, eng: 'Pusauli', hi: 'पुसौली'),
      SelectCityModel(id: 2, eng: 'Mohania', hi: 'मोहनिया'),
      SelectCityModel(id: 3, eng: 'Kudra', hi: 'कुदरा'),
      SelectCityModel(id: 4, eng: 'Bhabhua', hi: 'भभुआ'),
      SelectCityModel(id: 5, eng: 'Ramgarh', hi: 'रामगढ'),
      SelectCityModel(id: 6, eng: 'Nuaon', hi: 'नुआओं'),
      SelectCityModel(id: 7, eng: 'Durgawati', hi: 'दुर्गावती'),
      SelectCityModel(id: 8, eng: 'Chand', hi: 'चाँद'),
      SelectCityModel(id: 9, eng: 'Sonhan', hi: 'सोनहन'),
    ];
  }
}
