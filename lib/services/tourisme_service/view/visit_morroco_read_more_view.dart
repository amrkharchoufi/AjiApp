// lib/services/tourisme_service/view/visit_morroco_read_more_view.dart
// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:ajiapp/services/tourisme_service/model/tourism_model.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class VisitMorrocoRedMoreView extends StatefulWidget {
  final TouristSpot spot;

  const VisitMorrocoRedMoreView({
    super.key,
    required this.spot,
  });

  @override
  State<VisitMorrocoRedMoreView> createState() =>
      _VisitMorrocoRedMoreViewState();
}

class _VisitMorrocoRedMoreViewState extends State<VisitMorrocoRedMoreView> {
  late GoogleMapController _mapController;
  bool _isMapReady = false;

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // Add marker for the tourist spot
    if (widget.spot.latitude != 0 && widget.spot.longitude != 0) {
      _markers.add(
        Marker(
          markerId: MarkerId(widget.spot.id),
          position: LatLng(widget.spot.latitude, widget.spot.longitude),
          infoWindow: InfoWindow(
            title: widget.spot.name,
            snippet: widget.spot.city,
          ),
        ),
      );
    }
  }

  // Helper method to check if the image is a network image
  bool _isNetworkImage(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  // Open in maps app
  Future<void> _openInMaps() async {
    if (widget.spot.latitude == 0 || widget.spot.longitude == 0) return;

    final url =
        'https://www.google.com/maps/search/?api=1&query=${widget.spot.latitude},${widget.spot.longitude}';

    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      body: Container(
        width: ScreenSize.width,
        height: ScreenSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  MyappbarWidget(
                    title: "Visit Morocco",
                  ),
                  SizedBox(
                    height: ScreenSize.height / 120,
                  ),
                  Container(
                    width: ScreenSize.width / 1.1,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Column(
                      children: [
                        // Image
                        SizedBox(
                          height: ScreenSize.width / 1.2,
                          width: ScreenSize.width,
                          child: _isNetworkImage(widget.spot.imageUrl)
                              ? CachedNetworkImage(
                                  imageUrl: widget.spot.imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.grey[300],
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                )
                              : Image.asset(
                                  widget.spot.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                        ),

                        // Content
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenSize.width / 20,
                            vertical: ScreenSize.width / 20,
                          ),
                          width: ScreenSize.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Column(
                            children: [
                              // Title
                              Text(
                                widget.spot.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: ScreenSize.width / 40,
                              ),

                              // Opening hours
                              Row(
                                children: [
                                  Icon(Icons.watch_later_outlined),
                                  SizedBox(width: 5),
                                  Text(
                                    widget.spot.openingHours,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ScreenSize.width / 35,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: ScreenSize.width / 40,
                              ),

                              // Rating
                              Row(
                                children: [
                                  Text(
                                    widget.spot.rating,
                                    style: TextStyle(
                                      fontSize: ScreenSize.width / 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    "(${widget.spot.ratingCount})",
                                    style: TextStyle(
                                      fontSize: ScreenSize.width / 30,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenSize.width / 40,
                              ),

                              // Location
                              Row(
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(width: 5),
                                  Text(
                                    widget.spot.city,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ScreenSize.width / 35,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: ScreenSize.width / 20,
                              ),

                              // Entry Fee
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: gold.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  widget.spot.entryFee,
                                  style: TextStyle(
                                    color: gold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenSize.width / 35,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenSize.width / 20,
                              ),

                              // History section title
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "History",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenSize.width / 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenSize.width / 40,
                              ),

                              // History content
                              Text(
                                widget.spot.history.isNotEmpty
                                    ? widget.spot.history
                                    : "No historical information available.",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 35,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: ScreenSize.width / 20,
                              ),

                              // Map section (if coordinates are available)
                              if (widget.spot.latitude != 0 &&
                                  widget.spot.longitude != 0) ...[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Location",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ScreenSize.width / 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenSize.width / 40,
                                ),
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: GoogleMap(
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(widget.spot.latitude,
                                            widget.spot.longitude),
                                        zoom: 14,
                                      ),
                                      markers: _markers,
                                      onMapCreated: (controller) {
                                        _mapController = controller;
                                        setState(() {
                                          _isMapReady = true;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenSize.width / 20,
                                ),
                              ],

                              // View on Map button
                              ElevatedButton.icon(
                                onPressed: _openInMaps,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ajired,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ScreenSize.width / 12,
                                    vertical: ScreenSize.width / 40,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.map,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "View On Map",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: (ScreenSize.width / 22),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenSize.width / 10,
                  ),
                ],
              ),
            ),
            MyappbarWidget(
              title: "Visit Morocco",
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_isMapReady) {
      _mapController.dispose();
    }
    super.dispose();
  }
}
