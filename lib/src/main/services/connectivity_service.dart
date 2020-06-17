import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:popwoot/src/main/utils/connectivity_status.dart';

class ConnectivityService {

  var connectionStatusController = StreamController<ConnectivityStatus>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      //Convert this result to our enum
      var connectionStatus = _getStatusFromResult(result);
      //Emit this over stream
      connectionStatusController.add(connectionStatus);
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Wifi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}
