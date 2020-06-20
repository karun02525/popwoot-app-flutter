import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/constants.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:popwoot/src/main/utils/player_widget.dart';

typedef void OnError(Exception exception);

const kUrl1 = 'http://digifametechnology.com/mic.mp3';
const kUrl2 = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
const kUrl3 = 'http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p';

void main() {
  runApp(MaterialApp(home: Musix()));
}

class Musix extends StatefulWidget {
  @override
  _MusixState createState() => _MusixState();
}

class _MusixState extends State<Musix> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String localFilePath;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(title: Text('Musix')),
          body:Center(child: Container(
            child:remoteUrl())));
  }


  Widget remoteUrl() {
    return Wrap(
      direction: Axis.vertical,
      children: [
        PlayerWidget(url: kUrl1),
       // PlayerWidget(url: kUrl3),
        PlayerWidget(url: kUrl1, mode: PlayerMode.MEDIA_PLAYER),
      ]);
  }

}


class _Btn extends StatelessWidget {
  final String txt;
  final VoidCallback onPressed;

  const _Btn({Key key, this.txt, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 48.0,
        child: RaisedButton(child: Text(txt), onPressed: onPressed));
  }
}