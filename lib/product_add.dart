import 'package:flutter/material.dart';
import 'package:popwoot/ui/theme.dart';
import 'package:popwoot/ui/widgets/button_widget.dart';
import 'package:popwoot/ui/widgets/text_widget.dart';
import 'package:popwoot/ui/widgets/textfield_widget.dart';


class ProductAdds extends StatefulWidget {
  @override
  _ProductAddsState createState() => _ProductAddsState();
}

class _ProductAddsState extends State<ProductAdds> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        titleSpacing: 2.0,
        title: Text(
          "Add Product",
          style: TextStyle(
            letterSpacing: 1.0,
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            fontFamily: font,
          ),
        ),
      ),
     body:  Container(
         child: getEditBox(),
     ));
  }



  Widget getEditBox(){
       return Padding(
         padding: const EdgeInsets.only(top:8.0,left: 10.0,right: 10.0),
         child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[

                 TextWidget('Category Name'),
                 TextFieldWidget(
                   hintText: 'Enter category name',
                 ),

               TextWidget('Category Description'),
               TextFieldWidget(
                 minLine: 4,
                 hintText: 'Enter category description',
               ),

                TextWidget('Category urls'),
                TextFieldWidget(
                 hintText: 'Enter category urls',
               ),
               ButtonWidget(
                 title:'Add Category',)

             ],
         ),
       );
  }

}
