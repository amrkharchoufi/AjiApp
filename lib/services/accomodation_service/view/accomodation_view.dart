import 'package:ajiapp/routing.dart';
import 'package:ajiapp/services/accomodation_service/controller/hotel_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/hotel_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:ajiapp/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccomodationView extends StatelessWidget {
  const AccomodationView({super.key});

  @override
  Widget build(BuildContext context) {
    final HotelController controller = Get.put(HotelController());
    ScreenSize.init(context);

    // Calculate appropriate padding
    final horizontalPadding = ScreenSize.width / 30;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ajired,
        onPressed: () {
          Get.toNamed(Routes.MAP);
        },
        label: const Text("View on Map", style: TextStyle(color: Colors.white)),
        icon: const Icon(
          Icons.map,
          color: Colors.white,
        ),
      ),
      body: Container(
        width: ScreenSize.width,
        height: ScreenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(color: ajired),
                );
              } else if (controller.hotels.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.hotel, size: 64, color: ajired),
                      const SizedBox(height: 16),
                      const Text("No hotels available",
                          style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => controller.fetchHotels(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ajired,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Refresh"),
                      )
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await controller.fetchHotels();
                          controller
                              .filterByCity(controller.selectedCity.value);
                        },
                        displacement: 150,
                        color: ajired,
                        backgroundColor: Colors.white,
                        child: ListView(
                          physics: const ClampingScrollPhysics(),
                          children: [
                            const MyappbarWidget(title: "Hotels"),

                            // Filter section
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenSize.height / 60,
                                vertical: ScreenSize.height / 80,
                              ),
                              child: FilterChipsRow(),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding, vertical: 8),
                              child: const SectionHeader(title: "Recommended"),
                            ),
                            ...controller.filteredHotels.map((hotel) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: horizontalPadding, vertical: 8),
                                child: HotelWidget(
                                  key: ValueKey('hotel-${hotel.title}'),
                                  hotel: hotel,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),

            // AppBar always stays on top
            const MyappbarWidget(title: "Hotels"),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FilterChipsRow extends GetView<HotelController> {
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
    return Obx(() {
      return Row(
        children: [
          // City Filter Chip
          Expanded(
            child: CompositedTransformTarget(
              link: _cityLayerLink,
              child: GestureDetector(
                onTap: () => _toggleCityDropdown(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                              color: _isCityOpen.value ? Colors.white : ajired,
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
    });
  }
}
