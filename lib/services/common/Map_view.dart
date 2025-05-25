import 'package:ajiapp/routing.dart';
import 'package:ajiapp/services/accomodation_service/controller/hotel_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final HotelController controller = Get.put(HotelController());

  late LatLng _myhouse;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _myhouse = Get.arguments ?? const LatLng(0, 0);

    markers = controller.positions.asMap().entries.map((entry) {
      int index = entry.key;
      LatLng pos = entry.value;
      return Marker(
        markerId: MarkerId('marker_$index'),
        position: pos,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.NOTIFICATION);
            },
            icon: Icon(
              Icons.notifications_outlined,
              color: ajired,
              size: ScreenSize.width / 13,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.account_circle_outlined,
              color: ajired,
              size: ScreenSize.width / 12,
            ),
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _myhouse, zoom: 15),
        markers: markers,
        cloudMapId: 'cd31d568b85381c8e142ab30',
      ),
    );
  }
}
