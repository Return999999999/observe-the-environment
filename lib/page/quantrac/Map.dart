// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(9.557330, 105.888124),
    zoom: 11.5,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phân Bố Trạm"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: const GoogleMap(
          mapType: MapType.normal,
          scrollGesturesEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
          myLocationEnabled: false,
          initialCameraPosition: _initialCameraPosition),
    );
  }
}
