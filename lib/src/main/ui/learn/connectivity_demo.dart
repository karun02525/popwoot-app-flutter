import 'package:flutter/material.dart';
import 'package:popwoot/src/main/utils/connectivity_status.dart';
import 'package:provider/provider.dart';


class ConnectVitiyDemo extends StatefulWidget {
  @override
  _ConnectVitiyDemoState createState() => _ConnectVitiyDemoState();
}

class _ConnectVitiyDemoState extends State<ConnectVitiyDemo> {
  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           Text('Connection Status: $connectionStatus'),
            connectionStatus == ConnectivityStatus.Wifi // Check status and show different buttons
                ? FlatButton(
                    child: Text('Testing files'),
                    color: Colors.blue[600],
                    onPressed: () {})
                : FlatButton(
                    child: Text('Turn on Cellular Sync'),
                    color: Colors.red[600],
                    onPressed: () {},
                  ),
          ],
        ));
  }
}