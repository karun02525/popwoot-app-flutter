import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';

import 'MapUtils.dart';


class BottomSheetDialog extends StatelessWidget {
  Completer<GoogleMapController> _mapController = Completer();
  List<Marker> _markers = <Marker>[];

  BottomSheetDialog() {
    _markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(12.931349, 77.677611),
        infoWindow: InfoWindow(title: 'The title of the marker')));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          setContent(),
          setMap(context),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blueAccent,
                shape: StadiumBorder(),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close"),
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blueAccent,
                shape: StadiumBorder(),
                onPressed: () {
                  Navigator.pop(context);
                  MapUtils.openMap(12.931349, 77.677611);
                },
                child: Text("Open Map"),
              )
            ],
          )
        ]);
  }

  Widget setContent() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.0, bottom: 5),
            height: 40,
            width: 80,
            child: Image.network(
                'https://indian-retailer.s3.ap-south-1.amazonaws.com/s3fs-public/article5745.jpg'),
          ),
          TextWidget(
            left: 5.0,
            title: 'Croma Electronics',
            isBold: true,
          ),
        ]);
  }

  Widget setMap(context) {
    return Expanded(
        child: Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              //myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(12.931349, 77.677611), zoom: 18.0),
             // mapType: MapType.normal,
              //myLocationButtonEnabled: false,
             // compassEnabled: true,
              zoomControlsEnabled: false,
              markers: Set<Marker>.of(_markers),
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
            )));
  }
}
