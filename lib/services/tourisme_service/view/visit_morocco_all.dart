// lib/services/tourisme_service/view/visit_morocco_all.dart

import 'package:ajiapp/services/tourisme_service/controller/Tourisme_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
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
      // Show loading indicator
      if (controller.isLoadingTours.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(ajired),
              ),
              SizedBox(height: 16),
              Text(
                "Loading tours...",
                style: TextStyle(
                  color: ajired,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }

      // Show empty state message when no data is available
      if (controller.tours.isEmpty) {
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

            // Display tours list
            SingleChildScrollView(
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
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
