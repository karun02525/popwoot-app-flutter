import 'dart:io' show Platform;

import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:popwoot/src/main/config/constraints.dart';
import 'package:url_launcher/url_launcher.dart';



class Utils {

  static void openYoutube(String youtubeLink) async {
    if (Platform.isIOS) {
      if (await canLaunch(youtubeLink)) {
        await launch(youtubeLink, forceSafariVC: false);
      } else {
        if (await canLaunch(youtubeLink)) {
          await launch(youtubeLink);
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
        }
      }
    } else {
      if (await canLaunch(youtubeLink)) {
        await launch(youtubeLink);
      } else {
        throw 'Could not launch $youtubeLink';
      }
    }
  }


  static void plaYoutube(String url) {
    FlutterYoutube.playYoutubeVideoByUrl(
        apiKey: Config.api_youtube,
        videoUrl: url,
        autoPlay: true, //default falase
        fullScreen: true //default false

    );
  }
}
