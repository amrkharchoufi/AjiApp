import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  static const LatLng _myhouse = LatLng(33.909292413511956, -6.919676971167564);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(initialCameraPosition: CameraPosition(target: _myhouse,zoom: 13),
      cloudMapId: 'cd31d568b85381c8e142ab30'
      ),
    );
  }
}
