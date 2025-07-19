import 'package:ajiapp/services/tourisme_service/controller/Tourisme_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/visit_morroco_card1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitMoroccoHome extends StatefulWidget {
  const VisitMoroccoHome({super.key});

  @override
  State<VisitMoroccoHome> createState() => _VisitMoroccoHomeState();
}

class _VisitMoroccoHomeState extends State<VisitMoroccoHome> {
  final TourismeController controller = Get.find<TourismeController>();
  final PageController _pageController = PageController(viewportFraction: 0.95);
  final RxInt currentPageIndex = 0.obs;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Obx(() {
      if (controller.touristSpots.isEmpty &&
          controller.tours.isEmpty &&
          !controller.isLoadingSpots.value &&
          !controller.isLoadingTours.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.travel_explore, size: 64, color: Colors.grey),
              SizedBox(height: 20),
              Text(
                "No tourist spots available",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 10),
              Text(
                "Please add tourist spots",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        );
      }

      return Column(
        children: [
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
              ],
            ),
          ),
          SizedBox(height: ScreenSize.width / 40),

          // Tourist Spots Section
          SizedBox(
              height: ScreenSize.height / 2.3,
              child: controller.isLoadingSpots.value
                  ? _buildLoadingIndicator()
                  : _buildtouristspots()),

          // Scrolling Dots Indicator
          Obx(() {
            if (controller.isLoadingSpots.value ||
                controller.touristSpots.isEmpty) {
              return SizedBox.shrink(); // Don't show anything
            }

            int maxDots = 3;
            int active = currentPageIndex.value % maxDots;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(maxDots, (index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    height: 10,
                    width: index == active ? 24 : 10,
                    decoration: BoxDecoration(
                      color: index == active
                          ? ajired
                          : Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: index == active
                          ? [
                              BoxShadow(
                                color: ajired.withOpacity(0.3),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                  );
                }),
              ),
            );
          }),

          SizedBox(height: ScreenSize.width / 20),
        ],
      );
    });
  }

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
            style: TextStyle(color: ajired, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildtouristspots() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        currentPageIndex.value = index;
      },
      itemCount: controller.touristSpots.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width / 100),
          child: VisitMorrocoCard1(
            spot: controller.touristSpots[index],
            designred: false,
            width: ScreenSize.width / 1.08,
            height: ScreenSize.height / 2.3,
          ),
        );
      },
    );
  }
}
