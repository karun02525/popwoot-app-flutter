import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageLoadWidget extends StatelessWidget {
  final String imageUrl;
  ImageLoadWidget({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.fill,
      // placeholder: (context, url) => CircularProgressIndicator(),
       errorWidget: (context, url, error) => Image(image: AssetImage('assets/images/no_image.jpg')),
      )
    );
  }
}
