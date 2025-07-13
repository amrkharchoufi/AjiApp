// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:ajiapp/services/home/controller/home_controller.dart';
import 'package:ajiapp/services/map_service/controller/map_controller.dart';
import 'package:ajiapp/widgets/hotel_map_widget.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController controller = Get.put(MapController());
  final ScrollController _scrollController = ScrollController();
  final HomeController controllerhome = Get.find<HomeController>();

  GoogleMapController? _mapController;
  apple.AppleMapController? _appleMapController;

  /// Animate the horizontal ListView so that the card at [index] is perfectly centered.
  void _scrollToIndex(int index) {
    // 1) This must exactly match: card width (280) + horizontal padding (8 left + 8 right) = 296
    const double cardWidth = 280.0;
    const double horizontalPadding = 16.0; // 8 left + 8 right
    final double cardWidthWithPadding = cardWidth + horizontalPadding; // 296.0

    // 2) Item's starting offset from the left:
    final double itemOffset = index * cardWidthWithPadding;

    // 3) Viewport (visible area) width of the ListView:
    final double viewportWidth = _scrollController.position.viewportDimension;

    // 4) Centered offset formula:
    double centeredOffset =
        itemOffset - (viewportWidth / 2 - cardWidthWithPadding / 2);

    // 5) Clamp to valid scroll range [0, maxScrollExtent]
    final maxOffset = _scrollController.position.maxScrollExtent;
    if (centeredOffset < 0) centeredOffset = 0;
    if (centeredOffset > maxOffset) centeredOffset = maxOffset;

    _scrollController.animateTo(
      centeredOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use 25% of screen height for the bottom ListView:
    final double listHeight = MediaQuery.of(context).size.height * 0.25;
    ScreenSize.init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              controllerhome.checklogin(context, 1);
            },
            icon: Icon(
              Icons.notifications_outlined,
              color: ajired,
              size: MediaQuery.of(context).size.width / 13,
            ),
          ),
          IconButton(
            onPressed: () {
              controllerhome.checklogin(context, 0);
            },
            icon: Icon(
              Icons.account_circle_outlined,
              color: ajired,
              size: MediaQuery.of(context).size.width / 12,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // ────────────────────────────────────────────────────────────────
          // 1) GoogleMap wrapped in Obx so it rebuilds once `positions` is ready:
          Obx(() {
            final List<LatLng> posList = controller.positions;

            if (Platform.isIOS) {
              final Set<apple.Annotation> appleMarkers = {};

              for (int i = 0; i < posList.length; i++) {
                final loc = posList[i];
                appleMarkers.add(
                  apple.Annotation(
                    annotationId: apple.AnnotationId('hotel_marker_$i'),
                    position: apple.LatLng(loc.latitude, loc.longitude),
                    onTap: () {
                      final int hotelIndex =
                          controller.filteredHotels.indexWhere((hotel) {
                        return hotel.location.latitude == loc.latitude &&
                            hotel.location.longitude == loc.longitude;
                      });
                      if (hotelIndex != -1) {
                        _scrollToIndex(hotelIndex);
                      }
                    },
                  ),
                );
              }

              return SizedBox.expand(
                child: apple.AppleMap(
                  initialCameraPosition: apple.CameraPosition(
                    target: posList.isNotEmpty
                        ? apple.LatLng(
                            posList[0].latitude, posList[0].longitude)
                        : const apple.LatLng(31.7917, -7.0926),
                    zoom: 6,
                  ),
                  annotations: appleMarkers,
                  onMapCreated: (apple.AppleMapController controller) {
                    _appleMapController = controller;
                  },
                ),
              );
            } else {
              final Set<Marker> googleMarkers = {};

              for (int i = 0; i < posList.length; i++) {
                final loc = posList[i];
                googleMarkers.add(
                  Marker(
                    markerId: MarkerId('hotel_marker_$i'),
                    position: loc,
                    onTap: () {
                      final int hotelIndex =
                          controller.filteredHotels.indexWhere((hotel) {
                        return hotel.location.latitude == loc.latitude &&
                            hotel.location.longitude == loc.longitude;
                      });
                      if (hotelIndex != -1) {
                        _scrollToIndex(hotelIndex);
                      }
                    },
                  ),
                );
              }

              return SizedBox.expand(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: posList.isNotEmpty
                        ? posList[0]
                        : const LatLng(31.7917, -7.0926),
                    zoom: 6,
                  ),
                  onMapCreated: (GoogleMapController gmController) {
                    _mapController = gmController;
                  },
                  markers: googleMarkers,
                  cloudMapId: 'cd31d568b85381c8e142ab30',
                ),
              );
            }
          }),

          // Filter section at the top
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: FilterChipsRow(),
          ),

          // ────────────────────────────────────────────────────────────────
          // 2) Positioned ListView of hotel cards at the bottom (fixed 25% height)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Obx(
              () {
                if (controller.filteredHotels.isEmpty) {
                  return const SizedBox.shrink();
                }
                return SizedBox(
                  height: listHeight,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.filteredHotels.length,
                    itemBuilder: (context, index) {
                      final hotel = controller.filteredHotels[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            final target = hotel.location;

                            if (Platform.isIOS && _appleMapController != null) {
                              await _appleMapController!.moveCamera(
                                apple.CameraUpdate.newCameraPosition(
                                  apple.CameraPosition(
                                    target: apple.LatLng(
                                        target.latitude, target.longitude),
                                    zoom: 17,
                                  ),
                                ),
                              );
                            } else {
                              await _mapController?.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: target,
                                    zoom: 17,
                                  ),
                                ),
                              );
                            }
                          },

                          // 3) Wrap each card in a SizedBox(width:280.0) so we know its exact width:
                          child: SizedBox(
                            width: 280.0,
                            child: HotelMapWidget(
                              hotel_name: hotel.title,
                              Image_link: hotel.imageUrl,
                              Link: hotel.Link,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class FilterChipsRow extends GetView<MapController> {
  FilterChipsRow({super.key});

  final LayerLink _cityLayerLink = LayerLink();
  final RxBool _isCityOpen = false.obs;
  OverlayEntry? _cityOverlay;

  void _removeOverlays() {
    _cityOverlay?.remove();
    _cityOverlay = null;
    _isCityOpen.value = false;
  }

  void _toggleCityDropdown(BuildContext context) {
    if (_isCityOpen.value) {
      _removeOverlays();
    } else {
      _cityOverlay = _createCityOverlay(context);
      Overlay.of(context).insert(_cityOverlay!);
      _isCityOpen.value = true;
    }
  }

  OverlayEntry _createCityOverlay(BuildContext context) {
    final cities = controller.cities;
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlays,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 4,
            width: size.width,
            child: CompositedTransformFollower(
              link: _cityLayerLink,
              targetAnchor: Alignment.bottomCenter,
              followerAnchor: Alignment.topCenter,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];
                      final isSelected = controller.selectedCity.value == city;
                      return InkWell(
                        onTap: () {
                          controller.filterByCity(city);
                          _removeOverlays();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ajired.withOpacity(0.1)
                                : Colors.transparent,
                            border: index != cities.length - 1
                                ? Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade200))
                                : null,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: isSelected ? ajired : Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                city,
                                style: TextStyle(
                                  color: isSelected ? ajired : Colors.black87,
                                  fontSize: ScreenSize.width / 30,
                                  fontWeight: isSelected
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                ),
                              ),
                              if (isSelected) ...[
                                const Spacer(),
                                Icon(Icons.check, color: ajired, size: 16),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Obx(() {
        return Row(
          children: [
            // City Filter Chip
            Expanded(
              child: CompositedTransformTarget(
                link: _cityLayerLink,
                child: GestureDetector(
                  onTap: () => _toggleCityDropdown(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: _isCityOpen.value ? ajired : Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: ajired),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: _isCityOpen.value ? Colors.white : ajired,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              controller.selectedCity.value,
                              style: TextStyle(
                                color:
                                    _isCityOpen.value ? Colors.white : ajired,
                                fontSize: ScreenSize.width / 30,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          _isCityOpen.value
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: _isCityOpen.value ? Colors.white : ajired,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
