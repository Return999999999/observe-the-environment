// ignore_for_file: deprecated_member_use, constant_identifier_names, avoid_print, sort_child_properties_last, file_names

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const MAPBOX_ACCESS_TOKEN =
    'sk.eyJ1Ijoia29tYXg5OTk5OTkiLCJhIjoiY2xwYXhjNHpvMGN1djJrazdyNTV1OXJvbCJ9.BaxNBlOeyJ1hGZeKcFR77g';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  LatLng? myPosition;
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    markers.addAll([
      Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(9.557378, 105.887323),
        child: GestureDetector(
          onTap: () {
            _onMarkerTapped(const LatLng(9.557378, 105.887323),
                25); // Truyền nhiệt độ vào hàm _onMarkerTapped
          },
          child: const Column(
            children: <Widget>[
              Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40.0,
              ),
              Text(
                'Trạm 1',
                style: TextStyle(color: Colors.black),
              ),
              // Text(
              //   'Temperature: 25°C', // Hiển thị nhiệt độ
              // )
            ],
          ),
        ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: const LatLng(9.561041, 105.892141),
        child: GestureDetector(
          onTap: () {
            _onMarkerTapped(const LatLng(9.561041, 105.892141),
                35); // Truyền nhiệt độ vào hàm _onMarkerTapped
          },
          child: const Column(
            children: <Widget>[
              Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40.0,
              ),
              Text(
                'Trạm 2',
                style: TextStyle(color: Colors.black),
              ),
              // Text(
              //   'Temperature: 28°C', // Hiển thị nhiệt độ
              // )
            ],
          ),
        ),
      ),
    ]);
  }

  Future<void> getCurrentLocation() async {
    try {
      setState(() {
        myPosition = const LatLng(9.557378, 105.887323);
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _onMarkerTapped(LatLng position, int temperature) {
    String stationName = getStationName(position);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông tin trạm'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Tên: $stationName'),
              Text('Nhiệt độ: $temperature°C'), // Hiển thị nhiệt độ
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  String getStationName(LatLng position) {
    // Tìm tên trạm dựa trên vị trí marker
    if (position == const LatLng(9.557378, 105.887323)) {
      return 'Trạm 1';
    } else if (position == const LatLng(9.561041, 105.892141)) {
      return 'Trạm 2';
    } else {
      return 'Unknown Station';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPosition == null
          ? const CircularProgressIndicator()
          : FlutterMap(
              options: MapOptions(
                  center: myPosition, minZoom: 5, maxZoom: 25, zoom: 18),
              children: const [],
              nonRotatedChildren: [
                TileLayer(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                  additionalOptions: const {
                    'accessToken': MAPBOX_ACCESS_TOKEN,
                    'id': 'mapbox/streets-v12'
                  },
                ),
                MarkerLayer(
                  markers: markers,
                ),
              ],
            ),
    );
  }
}
