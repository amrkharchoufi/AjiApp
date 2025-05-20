// lib/services/tourisme_service/view/visit_morocco_home.dart

import 'package:ajiapp/services/tourisme_service/controller/Tourisme_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/visit_morocco_card2.dart';
import 'package:ajiapp/widgets/visit_morroco_card1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitMoroccoHome extends StatelessWidget {
  const VisitMoroccoHome({super.key});

  @override
  Widget build(BuildContext context) {
    final TourismeController controller = Get.find<TourismeController>();
    ScreenSize.init(context);

    return Obx(() {
      // Show empty state message when no data is available and not loading
      if (controller.touristSpots.isEmpty &&
          controller.tours.isEmpty &&
          !controller.isLoadingSpots.value &&
          !controller.isLoadingTours.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.travel_explore,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              Text(
                "No tourist spots available",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Please add tourist spots in Firebase",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      }

      return Column(
        children: [
          // Most Visited Tourist Spots Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize.height / 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Most Visits",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
          ),
          SizedBox(
            height: ScreenSize.width / 40,
          ),

          // Tourist spots section with loading indicator
          SizedBox(
            height: ScreenSize.height / 2.3,
            child: controller.isLoadingSpots.value
                ? _buildLoadingIndicator()
                : _buildTouristSpotsList(controller),
          ),

          SizedBox(
            height: ScreenSize.width / 20,
          ),

          // Multi City Tour Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize.height / 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Multi City Tour",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
          ),
          SizedBox(
            height: ScreenSize.width / 40,
          ),

          // Tours section with loading indicator
          SizedBox(
            height: ScreenSize.height / 2.3,
            child: controller.isLoadingTours.value
                ? _buildLoadingIndicator()
                : _buildToursList(controller),
          ),

          SizedBox(
            height: ScreenSize.width / 20,
          ),
        ],
      );
    });
  }

  // Clean loading indicator with brand color
  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ajired),
          ),
          SizedBox(height: 16),
          Text(
            "Loading...",
            style: TextStyle(
              color: ajired,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Tourist spots horizontal list
  Widget _buildTouristSpotsList(TourismeController controller) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          controller.checkAndLoadMoreSpots();
        }
        return true;
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.height / 60),
        child: Row(
          children: [
            if (controller.touristSpots.isNotEmpty)
              for (var spot in controller.touristSpots)
                Padding(
                  padding: EdgeInsets.only(right: ScreenSize.width / 30),
                  child: VisitMorrocoCard1(
                    spot: spot,
                    designred: false,
                    width: ScreenSize.width / 1.06,
                    height: ScreenSize.height / 2.3,
                  ),
                ),

            // Loading indicator at the end when loading more items
            if (controller.loadingMoreSpots.value)
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(ajired),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Tours horizontal list
  Widget _buildToursList(TourismeController controller) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          controller.checkAndLoadMoreTours();
        }
        return true;
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.height / 60),
        child: Row(
          children: [
            if (controller.tours.isNotEmpty)
              for (var tour in controller.tours)
                Padding(
                  padding: EdgeInsets.only(right: ScreenSize.width / 30),
                  child: VisitMoroccoCard2(
                    tour: tour,
                    designred: false,
                    width: ScreenSize.width / 1.06,
                    height: ScreenSize.height / 2.3,
                  ),
                ),

            // Loading indicator at the end when loading more items
            if (controller.loadingMoreTours.value)
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(ajired),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
