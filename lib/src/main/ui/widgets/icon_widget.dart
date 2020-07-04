import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final String mgs;
  Function onTap;
  bool isDisable;

  IconWidget({this.icon,this.mgs,this.onTap,this.isDisable=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:InkWell(
        onTap:isDisable?onTap:null,
       splashColor: Colors.cyanAccent,
      child: Row(
        children: <Widget>[
          Icon(icon,size: 18.0,color: Colors.grey[600]),
          TextWidget(title:' '+mgs, color: Colors.grey[600], fontSize: 12.0,)
        ],
      ))
    );
  }
}
      /*

      FlatButton.icon(
      color: Colors.redAccent,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddReview(),
                  settings: RouteSettings(
                      arguments: [data['pid'],data['pname'],data['pdesc'],data['ipath']])));
        },
        splashColor: Colors.cyanAccent,
        icon: Icon(AppIcons.ic_add_review, size: 20.0, color: Colors.grey[600]),
        label:
  }*/
