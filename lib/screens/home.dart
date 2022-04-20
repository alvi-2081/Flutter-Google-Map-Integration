import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _kGooglePlex = const CameraPosition(
      target: LatLng(24.900621787983635, 67.0137608401669), zoom: 14.4746);

  List<Marker> _marker = [];
  List<Marker> _list = const [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(24.900621787983635, 67.0137608401669),
        infoWindow: InfoWindow(title: "My current position")),
    Marker(
        markerId: MarkerId("2"),
        position: LatLng(24.90100015293075, 67.02561862411308),
        infoWindow: InfoWindow(title: "Usmania Society")),
    Marker(
        markerId: MarkerId("3"),
        position: LatLng(24.909952759883765, 67.0200396294886),
        infoWindow: InfoWindow(title: "Jalalabad Colony")),
    Marker(
        markerId: MarkerId("4"),
        position: LatLng(33.71066965869317, 73.1492286649635),
        infoWindow: InfoWindow(title: "Islamabad"))
  ];
  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: true,
          bottom: true,
          child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(_marker),
            // mapType: MapType.normal,
            // myLocationButtonEnabled: true,
            // myLocationEnabled: true,
            // compassEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled_outlined),
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(33.71066965869317, 73.1492286649635),
                  zoom: 14)));
          setState(() {});
        },
      ),
    );
  }
}
