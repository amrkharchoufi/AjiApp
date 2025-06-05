import 'package:ajiapp/routing.dart';
import 'package:ajiapp/services/map_service/controller/map_controller.dart';
import 'package:ajiapp/widgets/hotel_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ajiapp/settings/colors.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController controller = Get.put(MapController());
  final ScrollController _scrollController = ScrollController();

  LatLng target = const LatLng(34.020882, -6.841650);
  GoogleMapController? _mapController;

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
              size: MediaQuery.of(context).size.width / 13,
            ),
          ),
          IconButton(
            onPressed: () {},
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
            final Set<Marker> markers = {};

            for (int i = 0; i < posList.length; i++) {
              final loc = posList[i];
              markers.add(
                Marker(
                  markerId: MarkerId('hotel_marker_$i'),
                  position: loc,
                  onTap: () {
                    // Find the corresponding hotel index by matching Lat/Lng
                    final int hotelIndex = controller.hotels.indexWhere((hotel) {
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
                  target: posList.isNotEmpty ? posList[0] : target,
                  zoom: 13,
                ),
                onMapCreated: (GoogleMapController gmController) {
                  _mapController = gmController;
                },
                markers: markers,
                cloudMapId: 'cd31d568b85381c8e142ab30',
              ),
            );
          }),

          // ────────────────────────────────────────────────────────────────
          // 2) Positioned ListView of hotel cards at the bottom (fixed 25% height)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Obx(
              () {
                if (controller.hotels.isEmpty) {
                  return const SizedBox.shrink();
                }
                return SizedBox(
                  height: listHeight,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.hotels.length,
                    itemBuilder: (context, index) {
                      final hotel = controller.hotels[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            // Center the map when a card is tapped:
                            await _mapController?.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: hotel.location,
                                  zoom: 17,
                                ),
                              ),
                            );
                          },
                          // 3) Wrap each card in a SizedBox(width:280.0) so we know its exact width:
                          child: SizedBox(
                            width: 280.0,
                            child: HotelMapWidget(
                              hotel_name: hotel.title,
                              Image_link: hotel.imageUrl,
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
