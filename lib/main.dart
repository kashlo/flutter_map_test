import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Google Maps demo')),
      body: MapsDemo(

      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: (){},
//        child: Icon(Icons.add,
//          size: 28.0,
//          color: Colors.white,
//        ),
//      )
    ),
  ));
}

class MapsDemo extends StatefulWidget {
  @override
  State createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {
  String _platformVersion = 'Unknown';
  Permission permission;
  GoogleMapController mapController;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await SimplePermissions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }


  @override
  Widget build(BuildContext context) {
//    return Padding(
////      padding: EdgeInsets.all(15.0),
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
//          Expanded(
//            child: GoogleMap(
//                onMapCreated: _onMapCreated,
//                options: GoogleMapOptions(myLocationEnabled: true)
//
//            )
//          ),
          Text('Running on: $_platformVersion\n'),
//          RaisedButton(
//              onPressed: checkPermission,
//              child: new Text("check Permission")),
          RaisedButton(
              onPressed: requestPermission,
              child: new Text("Request Location Permission")),
          Center(
            child: SizedBox(
              width: 300.0,
              height: 400.0,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                  options: GoogleMapOptions(myLocationEnabled: true)
              ),
            ),
          ),
//          RaisedButton(
//            child: const Text('Go to London'),
//            onPressed: mapController == null ? null : () {
//              mapController.animateCamera(CameraUpdate.newCameraPosition(
//                const CameraPosition(
//                  bearing: 270.0,
//                  target: LatLng(51.5160895, -0.1294527),
//                  tilt: 30.0,
//                  zoom: 17.0,
//                ),
//              ));
//            },
//          ),
        ],
      );
//    );
  }

  requestPermission() async {
    final res = await SimplePermissions.requestPermission(Permission.AccessFineLocation);
    print("permission request result is " + res.toString());
  }

  checkPermission() async {
    bool res = await SimplePermissions.checkPermission(Permission.AccessFineLocation);
    print("permission is " + res.toString());
  }

  getPermissionStatus() async {
    final res = await SimplePermissions.getPermissionStatus(permission);
    print("permission status is " + res.toString());
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() { mapController = controller; });
    mapController.addMarker(MarkerOptions(
      position: LatLng(
          50.368371, 30.457103
//        center.latitude + sin(_markerCount * pi / 6.0) / 20.0,
//        center.longitude + cos(_markerCount * pi / 6.0) / 20.0,
      ),
      infoWindowText: InfoWindowText('Scooter 1', ''),
      icon: BitmapDescriptor.fromAsset('assets/marker.png', )
    ));
  }
}