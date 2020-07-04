import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';

import 'image_load_widget.dart';

class ImageSliderWidget extends StatefulWidget {
  final List<String> imgList;
  ImageSliderWidget({Key key,this.imgList}):super(key:key);

  @override
  _ImageSliderWidgetState createState() => _ImageSliderWidgetState(imgList);
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  List<String> imgList=[];
  int _current = 0;
  int total=0;

  _ImageSliderWidgetState(imgList){
    this.imgList=imgList;
    total=imgList.length;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.0,
      width: double.infinity,
      child:
      Stack(
      children: [
        slider(),
        countWidget()
      ],
    ));
  }

  Widget slider() {
    return Builder(
      builder: (context) {
        final double height = MediaQuery.of(context).size.height;
        return CarouselSlider(
          options: CarouselOptions(
              height: height,
              autoPlay: false,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          items: imgList
              .map((item) => Container(
            child: Center(
                child:ImageLoadWidget(imageUrl:item))
          ))
              .toList(),
        );
      },
    );
  }


  Widget countWidget(){
    return Container(
      margin: EdgeInsets.only(top: 8.0,right: 10.0),
      child: Align(
          alignment: Alignment.topRight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
              child: Container(
                 width: 24.0,
                 height: 15.0,
                 color: Colors.grey,
                 child:Center(child: TextWidget(title: '${_current+1}/$total',fontSize: 10.0,)),
              ),
          ),
      ),
    );
  }
}



