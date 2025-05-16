// lib/services/tourisme_service/view/visit_morocco_all.dart
import 'package:ajiapp/services/tourisme_service/controller/Tourisme_controller.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/tourism_shimmer_cards.dart';
import 'package:ajiapp/widgets/visit_morocco_card2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitMoroccoAll extends StatelessWidget {
  const VisitMoroccoAll({super.key});

  @override
  Widget build(BuildContext context) {
    final TourismeController controller = Get.find<TourismeController>();
    ScreenSize.init(context);

    return Obx(() {
      // Show empty state message when no data is available and not loading
      if (controller.tours.isEmpty &&
          !controller.isLoadingTours.value &&
          !controller.showToursShimmer.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.directions_bus,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              Text(
                "No tours available",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Please add tours in Firebase",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.height / 60),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Most Popular",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle view all tap
                  },
                  child: Text(
                    "View all",
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenSize.width / 40,
            ),
            // Display shimmer placeholders while loading
            if (controller.showToursShimmer.value)
              for (int i = 0; i < 3; i++)
                Column(
                  children: [
                    TourismShimmerCards(isSpotCard: false),
                    SizedBox(
                      height: ScreenSize.width / 30,
                    ),
                  ],
                )
            // Display actual data once loaded
            else
              NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    // When user scrolls to the end, check if we need to load more
                    controller.checkAndLoadMoreTours();
                  }
                  return true;
                },
                child: Column(
                  children: [
                    // Display all tours
                    for (var tour in controller.tours)
                      Column(
                        children: [
                          VisitMoroccoCard2(
                            tour: tour,
                            designred: false,
                            width: ScreenSize.width / 1.06,
                            height: ScreenSize.height / 2.3,
                          ),
                          SizedBox(
                            height: ScreenSize.width / 30,
                          ),
                        ],
                      ),

                    // Loading indicator at the bottom when loading more items
                    if (controller.loadingMoreTours.value)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),

                    // "End of list" indicator when no more items to load
                    if (!controller.hasMoreTours.value &&
                        controller.tours.isNotEmpty)
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
          ],
        ),
      );
    });
  }
}
