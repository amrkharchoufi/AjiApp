// lib/services/tourisme_service/view/visit_morroco_read_more_view.dart
// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'dart:io';

import 'package:ajiapp/backend/authentification_functions.dart';
import 'package:ajiapp/services/accomodation_service/controller/hotel_controller.dart';
import 'package:ajiapp/services/accomodation_service/model/hotel_model.dart';
import 'package:ajiapp/services/profile/controller/save_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewMoreHotelView extends StatefulWidget {
  final Hotel_model spot;

  const ViewMoreHotelView({
    super.key,
    required this.spot,
  });

  @override
  State<ViewMoreHotelView> createState() => _ViewMoreHotelViewState();
}

class _ViewMoreHotelViewState extends State<ViewMoreHotelView> {
  late GoogleMapController _mapController;
  bool _isMapReady = false;

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // Add marker for the tourist spot
    if (widget.spot.location.latitude != 0 &&
        widget.spot.location.longitude != 0) {
      _markers.add(
        Marker(
          markerId: MarkerId(widget.spot.id),
          position: LatLng(
              widget.spot.location.latitude, widget.spot.location.longitude),
          infoWindow: InfoWindow(
            title: widget.spot.title,
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

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<HotelController>()) {
      Get.lazyPut(() => HotelController());
    }
    final HotelController controller = Get.find<HotelController>();
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
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  MyappbarWidget(
                    title: "Accommodation",
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
                        Stack(
                          children: [
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
                            Positioned(
                              top: ScreenSize.height / 100,
                              left: ScreenSize.width / 50,
                              child: Obx(() {
                                return Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          controller.likedSpots[
                                                      widget.spot.id] ==
                                                  true
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          color: Colors.red,
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.white)),
                                        onPressed: () async {
                                          bool logged =
                                              await checkIfUserIsLoggedIn();
                                          if (logged) {
                                            await controller
                                                .toggleLike(widget.spot.id);
                                          } else {
                                            Get.snackbar(
                                              'Login required',
                                              'Login to interacte with posts',
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.white,
                                              colorText: Colors.black,
                                              duration: Duration(seconds: 3),
                                              margin: EdgeInsets.all(16),
                                              borderRadius: 8,
                                            );
                                          }
                                        }),
                                    IconButton(
                                        icon: Icon(
                                          controller.savedSpots[
                                                      widget.spot.id] ==
                                                  true
                                              ? Icons.bookmark
                                              : Icons.bookmark_border,
                                          color: Colors.amber,
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.white)),
                                        onPressed: () async {
                                          bool logged =
                                              await checkIfUserIsLoggedIn();

                                          if (logged) {
                                            await controller
                                                .toggleSave(widget.spot.id);

                                            // Only call if SaveSpotController is registered
                                            if (Get.isRegistered<
                                                SaveSpotController>()) {
                                              await Get.find<
                                                      SaveSpotController>()
                                                  .loadSavedPosts();
                                            }
                                          } else {
                                            Get.snackbar(
                                              'Login required',
                                              'Login to interact with posts',
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.white,
                                              colorText: Colors.black,
                                              duration: Duration(seconds: 3),
                                              margin: EdgeInsets.all(16),
                                              borderRadius: 8,
                                            );
                                          }
                                        }),
                                  ],
                                );
                              }),
                            ),
                          ],
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
                                widget.spot.title,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: ScreenSize.width / 40,
                              ),
                              Obx(() {
                                final count = controller
                                        .likeCounts[widget.spot.id]?.value ??
                                    0;
                                return Row(
                                  children: [
                                    Icon(Icons.favorite),
                                    SizedBox(width: 5),
                                    Text(
                                      "$count",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: ScreenSize.width / 35,
                                      ),
                                    )
                                  ],
                                );
                              }),
                              SizedBox(
                                height: ScreenSize.width / 40,
                              ),

                              // Opening hours
                              Row(
                                children: [
                                  Icon(Icons.attach_money),
                                  SizedBox(width: 5),
                                  Text(
                                    widget.spot.price,
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
                              // Row(
                              //   children: [
                              //     Text(
                              //       widget.spot.rating,
                              //       style: TextStyle(
                              //         fontSize: ScreenSize.width / 25,
                              //         color: Colors.black,
                              //       ),
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //     ),
                              //     Text(
                              //       "(${widget.spot.ratingCount})",
                              //       style: TextStyle(
                              //         fontSize: ScreenSize.width / 30,
                              //         color: Colors.black,
                              //       ),
                              //     ),
                              //   ],
                              // ),
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

                              // History section title
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Description",
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
                                widget.spot.description.isNotEmpty
                                    ? widget.spot.description
                                    : "No information available.",
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
                              if (widget.spot.location.latitude != 0 &&
                                  widget.spot.location.longitude != 0) ...[
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
                                      child: Platform.isIOS
                                          ? apple.AppleMap(
                                              initialCameraPosition:
                                                  apple.CameraPosition(
                                                target: apple.LatLng(
                                                    widget
                                                        .spot.location.latitude,
                                                    widget.spot.location
                                                        .longitude),
                                                zoom: 14,
                                              ),
                                              annotations: {
                                                apple.Annotation(
                                                  annotationId:
                                                      apple.AnnotationId(
                                                          widget.spot.id),
                                                  position: apple.LatLng(
                                                      widget.spot.location
                                                          .latitude,
                                                      widget.spot.location
                                                          .longitude),
                                                ),
                                              },
                                            )
                                          : GoogleMap(
                                              initialCameraPosition:
                                                  CameraPosition(
                                                target: LatLng(
                                                    widget
                                                        .spot.location.latitude,
                                                    widget.spot.location
                                                        .longitude),
                                                zoom: 14,
                                              ),
                                              markers: _markers,
                                              onMapCreated: (controller) {
                                                _mapController = controller;
                                                setState(() {
                                                  _isMapReady = true;
                                                });
                                              },
                                            )),
                                ),
                                SizedBox(
                                  height: ScreenSize.width / 20,
                                ),
                              ],

                              // View on Map button
                              ElevatedButton.icon(
                                onPressed: () async {
                                  final url = Uri.parse(widget.spot.Link);

                                  await launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                                },
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
                                  "Book now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: (ScreenSize.width / 22),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenSize.width / 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Reviews",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ScreenSize.width / 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () async {
                                      bool logged =
                                          await checkIfUserIsLoggedIn();
                                      if (logged) {
                                        controller
                                            .showReviewDialog(widget.spot.id);
                                      } else {
                                        Get.snackbar(
                                          'Login required',
                                          'Login to interacte with posts',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.white,
                                          colorText: Colors.black,
                                          duration: Duration(seconds: 3),
                                          margin: EdgeInsets.all(16),
                                          borderRadius: 8,
                                        );
                                      }
                                    },
                                    icon: Icon(Icons.rate_review),
                                    label: Text("Add Review"),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: ScreenSize.width / 40,
                              ),
                              Obx(() {
                                if (!controller.loadedReviewSpots
                                    .contains(widget.spot.id)) {
                                  controller.loadReviews(widget.spot.id);
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                final spotReviews =
                                    controller.reviews[widget.spot.id] ?? [];

                                if (spotReviews.isEmpty) {
                                  return const Text("No reviews yet.");
                                }

                                return Column(
                                  children: [
                                    ...controller.reviews[widget.spot.id]!
                                        .map<Widget>((review) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: ajired,
                                              child: Icon(Icons.person,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          review['userName'] ??
                                                              'Anonymous',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                        ),
                                                      ),
                                                      RatingBarIndicator(
                                                        rating:
                                                            (review['rating'] ??
                                                                    0)
                                                                .toDouble(),
                                                        itemBuilder: (context,
                                                                _) =>
                                                            const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber),
                                                        itemCount: 5,
                                                        itemSize: 16.0,
                                                        direction:
                                                            Axis.horizontal,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    review['comment'] ?? '',
                                                    softWrap: true,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                );
                              })
                            ],
                          ),
                        ),
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
              title: "Accomodation",
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
