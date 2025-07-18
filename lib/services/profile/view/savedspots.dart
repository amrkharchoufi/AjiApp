import 'package:ajiapp/services/profile/controller/save_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/hotel_widget.dart';
import 'package:ajiapp/widgets/service_name_widget.dart';
import 'package:ajiapp/widgets/visit_morroco_card1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Savedspots extends StatelessWidget {
  const Savedspots({super.key});

  @override
  Widget build(BuildContext context) {
    final SaveSpotController controller = Get.put(SaveSpotController());
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
                              : _buildTouristSpotsList(controller),
                        ),

                        SizedBox(
                          height: ScreenSize.width / 20,
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: ScreenSize.height / 100,
                  ),
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
                          height: ScreenSize.height / 2.3,
                          child: controller.isLoading.value
                              ? _buildLoadingIndicator()
                              : _buildaccommodationsList(controller),
                        ),

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
}

// Tourist spots horizontal list
Widget _buildTouristSpotsList(SaveSpotController controller) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) => Row(children: [
      SizedBox(width: ScreenSize.width / 30),
      VisitMorrocoCard1(
        spot: controller.savedTouristSpots[index],
        designred: false,
        width: ScreenSize.width / 1.06,
        height: ScreenSize.height / 2.3,
      ),
      if (index == controller.savedTouristSpots.length - 1)
        SizedBox(width: ScreenSize.width / 30),
    ]),
    itemCount: controller.savedTouristSpots.length,
  );
}

// Tourist spots horizontal list
Widget _buildaccommodationsList(SaveSpotController controller) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) => Row(children: [
      SizedBox(width: ScreenSize.width / 30),
      HotelWidget(
        key: ValueKey('hotel-${controller.savedAccommodations[index].title}'),
        hotel: controller.savedAccommodations[index],
      ),
      if (index == controller.savedAccommodations.length - 1)
        SizedBox(width: ScreenSize.width / 30),
    ]),
    itemCount: controller.savedAccommodations.length,
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
