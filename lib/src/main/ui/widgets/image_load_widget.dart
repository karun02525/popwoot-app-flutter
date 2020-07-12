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
                child: Image.network(
                  Config.baseImageUrl + imageUrl,
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
              );
  }

  Widget getProfileImage() {
    return Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.only(right: 5.0),
        child: imageUrl == null
            ? CircleAvatar(child: Text(name.toString().toUpperCase()[0]))
            : CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                backgroundColor: Colors.transparent,
              ));
  }
}
