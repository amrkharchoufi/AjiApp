// lib/services/tourisme_service/view/visit_morroco_city.dart

import 'package:ajiapp/services/tourisme_service/controller/Tourisme_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/visit_morroco_card1.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitMoroccoCity extends StatelessWidget {
  final String city;
  const VisitMoroccoCity({super.key, this.city = "All the Country"});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<TourismeController>(() => TourismeController());
    final TourismeController controller = Get.find<TourismeController>();
    ScreenSize.init(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.height / 60),
      child: Obx(() {
        // Show loading indicator
        if (controller.isLoadingCities.value) {
          return _buildLoadingContainer("Loading city information...");
        }

        // Get city data
        final cityData = controller.cities.firstWhere((c) => c.name == city,
            orElse: () => controller.cities.first);

        // Filter spots for this city
        final citySpots = controller.getSpotsByCityAndInterest(city);

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
                    // City image
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(17)),
                      child: CachedNetworkImage(
                        imageUrl: cityData.imageUrl,
                        width: double.infinity,
                        height: ScreenSize.height / 4,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: ScreenSize.height / 4,
                          color: Colors.grey[300],
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(ajired),
                            ),
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
                      ),
                    ),

                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: ScreenSize.height / 5),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenSize.width / 20,
                              vertical: ScreenSize.width / 30,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // City name and selected interests
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Location",
                                      style: TextStyle(
                                        fontSize: ScreenSize.width / 30,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      city,
                                      style: TextStyle(
                                        fontSize: ScreenSize.width / 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    if (controller
                                        .selectedInterests.isNotEmpty) ...[
                                      SizedBox(height: 12),
                                      Text(
                                        "Selected Interests",
                                        style: TextStyle(
                                          fontSize: ScreenSize.width / 30,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: controller.selectedInterests
                                            .map((interest) => Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        // ignore: deprecated_member_use
                                                        ajired.withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Text(
                                                    interest,
                                                    style: TextStyle(
                                                      color: ajired,
                                                      fontSize:
                                                          ScreenSize.width / 30,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Display tourist spots
                          if (controller.isLoadingSpots.value)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 32.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(ajired),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      "Loading tourist spots...",
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else if (citySpots.isEmpty)
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    controller.selectedInterests.isEmpty
                                        ? "No tourist spots found in $city"
                                        : "No tourist spots found matching the selected filters",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: ScreenSize.width / 25,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
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
                                  SizedBox(height: ScreenSize.width / 30),
                                ],
                              ),
                        ],
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

  // Helper method for a clean loading container
  Widget _buildLoadingContainer(String message) {
    return Container(
      width: ScreenSize.width,
      height: ScreenSize.height / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ajired),
            ),
            SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
