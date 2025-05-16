// lib/services/tourisme_service/view/visit_morroco_city.dart
import 'package:ajiapp/services/tourisme_service/controller/Tourisme_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/tourism_shimmer_cards.dart';
import 'package:ajiapp/widgets/visit_morroco_card1.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class VisitMoroccoCity extends StatelessWidget {
  final String city;
  const VisitMoroccoCity({super.key, required this.city});

  // Helper method to check if the image is a network image
  bool _isNetworkImage(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final TourismeController controller = Get.find<TourismeController>();
    ScreenSize.init(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.height / 60),
      child: Obx(() {
        // Get city data
        final cityData = controller.cities.firstWhere((c) => c.name == city,
            orElse: () => controller.cities.first);

        // Filter spots for this city
        final citySpots = controller.getSpotsByCity(city);

        return DefaultTabController(
          length: 2,
          child: Container(
            width: ScreenSize.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    // Show shimmer for image while loading
                    if (controller.showCitiesShimmer.value)
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: ScreenSize.height / 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(17)),
                          ),
                        ),
                      )
                    else
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(17)),
                        child: _isNetworkImage(cityData.imageUrl)
                            ? CachedNetworkImage(
                                imageUrl: cityData.imageUrl,
                                width: double.infinity,
                                height: ScreenSize.height / 4,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  height: ScreenSize.height / 4,
                                  color: Colors.grey[300],
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  height: ScreenSize.height / 4,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 50,
                                  ),
                                ),
                              )
                            : Image.asset(
                                cityData.imageUrl,
                                width: double.infinity,
                                height: ScreenSize.height / 4,
                                fit: BoxFit.cover,
                              ),
                      ),
                    NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          // When user scrolls to the end, check if we need to load more
                          controller.checkAndLoadMoreSpots();
                        }
                        return true;
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: ScreenSize.height / 5,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenSize.width / 20,
                                  vertical: ScreenSize.width / 30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: Column(
                                spacing: ScreenSize.width / 30,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "City",
                                        style: TextStyle(
                                          fontSize: ScreenSize.width / 25,
                                          color: gold,
                                        ),
                                      ),
                                      Text(
                                        "Interest",
                                        style: TextStyle(
                                          fontSize: ScreenSize.width / 25,
                                          color: gold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        city,
                                        style: TextStyle(
                                          fontSize: ScreenSize.width / 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        controller
                                                .selectedInterest.value.isEmpty
                                            ? "All"
                                            : controller.selectedInterest.value,
                                        style: TextStyle(
                                          fontSize: ScreenSize.width / 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Display tourist spots for this city
                            if (controller.showSpotsShimmer.value)
                              for (int i = 0; i < 3; i++)
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: TourismShimmerCards(isSpotCard: true),
                                )
                            else if (citySpots.isEmpty)
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  "No tourist spots found for $city",
                                  style: TextStyle(
                                    fontSize: ScreenSize.width / 25,
                                  ),
                                ),
                              )
                            else
                              for (var spot in citySpots)
                                Column(
                                  children: [
                                    VisitMorrocoCard1(
                                      spot: spot,
                                      width: ScreenSize.width / 1.06,
                                      height: ScreenSize.height / 2.3,
                                      designred: true,
                                    ),
                                    SizedBox(
                                      height: ScreenSize.width / 30,
                                    ),
                                  ],
                                ),

                            // Loading indicator at the bottom when loading more items
                            if (controller.loadingMoreSpots.value)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),

                            // "End of list" indicator when no more items to load
                            if (!controller.hasMoreSpots.value &&
                                citySpots.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  "You've reached the end",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
