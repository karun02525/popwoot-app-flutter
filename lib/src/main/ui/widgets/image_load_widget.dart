import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/config/constraints.dart';

class ImageLoadWidget extends StatelessWidget {
  final String imageUrl;
  bool isProfile;
  String name;

  ImageLoadWidget(
      {@required this.imageUrl, this.isProfile = false, this.name = "Popwoot"});

  @override
  Widget build(BuildContext context) {
    return isProfile
        ? getProfileImage()
        : imageUrl == null
            ? Container(
                height: 230.0,
                width: double.infinity,
                child: Image(image: AssetImage('assets/images/no_image.jpg')))
            : Container(
                height: 230.0,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: Config.baseImageUrl + imageUrl,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) =>
                      Image(image: AssetImage('assets/images/no_image.jpg')),
                ));
  }

  Widget getProfileImage() {
    return Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.only(right: 5.0),
        child: imageUrl == null
            ? CircleAvatar(child: Text(name.toString().toUpperCase()[0]))
            : CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: imageUrl,
                fit: BoxFit.fill,
              ));
  }
}
