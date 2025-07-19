import 'package:ajiapp/services/profile/controller/save_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/hotel_widget.dart';
import 'package:ajiapp/widgets/service_name_widget.dart';
import 'package:ajiapp/widgets/visit_morroco_card1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Savedspots extends StatelessWidget {
  Savedspots({super.key});
  final SaveSpotController controller = Get.put(SaveSpotController());
  final PageController _pageController = PageController(viewportFraction: 0.95);
  final PageController _pageControllerhotel =
      PageController(viewportFraction: 0.95);
  final RxInt currentPageIndexhotel = 0.obs;
  final RxInt currentPageIndexspots = 0.obs;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
      width: ScreenSize.width,
      height: ScreenSize.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: [
                AppBar(
                  backgroundColor: ajired,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                ServiceNameWidget(name: "Saved posts")
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenSize.width / 30, vertical: 8),
                        child: Text("Visit morroco",
                            style: TextStyle(
                              fontSize: SizeConfig.getBlockSizeHorizontal(7),
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                  Obx(() {
                    // Show empty state message when no data is available and not loading
                    if (controller.savedTouristSpots.isEmpty &&
                        !controller.isLoading.value) {
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
                              "Please add tourist spots",
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
                        // Tourist spots section with loading indicator
                        SizedBox(
                          height: ScreenSize.height / 2.3,
                          child: controller.isLoading.value
                              ? _buildLoadingIndicator()
                              : _buildTouristSpotsList(),
                        ),
                        // Scrolling Dots Indicator
                        Obx(() {
                          if (controller.savedTouristSpots.isEmpty &&
                              !controller.isLoading.value) {
                            return SizedBox.shrink(); // Don't show anything
                          }
                          if (controller.savedTouristSpots.length == 1) {
                            return SizedBox.shrink();
                          }

                          int maxDots = 3;
                          int active = currentPageIndexspots.value % maxDots;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(maxDots, (index) {
                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
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
                      ],
                    );
                  }),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenSize.width / 30, vertical: 8),
                        child: Text("Accomodations",
                            style: TextStyle(
                              fontSize: SizeConfig.getBlockSizeHorizontal(7),
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                  Obx(() {
                    // Show empty state message when no data is available and not loading
                    if (controller.savedAccommodations.isEmpty &&
                        !controller.isLoading.value) {
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
                              "No Hotels available",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Please add Hotels",
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
                        // Tourist spots section with loading indicator
                        SizedBox(
                          height: ScreenSize.height / 3,
                          child: controller.isLoading.value
                              ? _buildLoadingIndicator()
                              : _buildaccommodationsList(controller),
                        ),
                        // Scrolling Dots Indicator
                        Obx(() {
                          if (controller.savedAccommodations.isEmpty &&
                              !controller.isLoading.value) {
                            return SizedBox.shrink(); // Don't show anything
                          }
                          if (controller.savedAccommodations.length == 1) {
                            return SizedBox.shrink();
                          }
                          int maxDots = 3;
                          int active = currentPageIndexhotel.value % maxDots;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(maxDots, (index) {
                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
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
                        SizedBox(
                          height: ScreenSize.width / 20,
                        ),
                      ],
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  // Tourist spots horizontal list
  Widget _buildTouristSpotsList() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        currentPageIndexspots.value = index;
      },
      itemCount: controller.savedTouristSpots.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width / 100),
          child: VisitMorrocoCard1(
            spot: controller.savedTouristSpots[index],
            designred: false,
            width: ScreenSize.width / 1.08,
            height: ScreenSize.height / 2.3,
          ),
        );
      },
    );
  }

// Tourist spots horizontal list
  Widget _buildaccommodationsList(SaveSpotController controller) {
    return PageView.builder(
      controller: _pageControllerhotel,
      onPageChanged: (index) {
        currentPageIndexhotel.value = index;
      },
      itemCount: controller.savedAccommodations.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width / 80),
          child: HotelWidget(
            key: ValueKey(
                'hotel-${controller.savedAccommodations[index].title}'),
            hotel: controller.savedAccommodations[index],
          ),
        );
      },
    );
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
}
