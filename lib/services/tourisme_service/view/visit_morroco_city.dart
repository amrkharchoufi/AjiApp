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

        // Show loading spinner when data is loading
        if (controller.isLoadingSpots.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // Show error message if there's an error
        if (controller.errorSpots.isNotEmpty) {
          return Center(
            child: Text('Error loading data. Please try again.'),
          );
        }

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
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(17)),
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
                    SingleChildScrollView(
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
                                      controller.selectedInterest.value.isEmpty
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
                          if (citySpots.isEmpty)
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
}
