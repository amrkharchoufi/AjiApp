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
      body: Container(
        width: ScreenSize.width,
        height: ScreenSize.height,
        decoration: BoxDecoration(
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
                      SizedBox(height: 16),
                      Text("No hotels available",
                          style: TextStyle(fontSize: 18)),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => controller.fetchHotels(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ajired,
                          foregroundColor: Colors.white,
                        ),
                        child: Text("Refresh"),
                      )
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    // Main list content

                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo.metrics.pixels >
                                  scrollInfo.metrics.maxScrollExtent - 200 &&
                              controller.hasMoreData.value &&
                              !controller.isLoadingMore.value) {
                            controller.loadMoreHotels();
                          }
                          return true;
                        },
                        child: ListView(
                          // itemCount: controller.hotels.length +
                          //     (controller.hasMoreData.value ? 1 : 0),
                          // itemBuilder: (context, index) {
                          //   // Show loading indicator at the end
                          //   if (index == controller.hotels.length) {
                          //     return Padding(
                          //       padding: EdgeInsets.symmetric(vertical: 16),
                          //       child: Center(
                          //           child: CircularProgressIndicator(
                          //               color: ajired)),
                          //     );
                          //   }

                          //   // Show hotel item
                          //   return Padding(
                          //     padding: EdgeInsets.only(bottom: 16),
                          //     child: HotelWidget(
                          //       key: ValueKey(
                          //           'hotel-${controller.hotels[index].title}'),
                          //       hotel: controller.hotels[index],
                          //     ),
                          //   );
                          // },

                          children: [
                            MyappbarWidget(title: "Hotels"),
                            // Section header outside ListView to prevent it from scrolling
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding, vertical: 8),
                              child: SectionHeader(title: "Recommended"),
                            ),
                            ...controller.hotels.map((hotel) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: horizontalPadding, vertical: 8),
                                child: HotelWidget(
                                  key: ValueKey('hotel-${hotel.title}'),
                                  hotel: hotel,
                                ),
                              );
                            }),

                            // Show loading indicator at the end
                            if (controller.isLoadingMore.value)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child:
                                      CircularProgressIndicator(color: ajired),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),

            // AppBar always stays on top
            MyappbarWidget(title: "Hotels"),
          ],
        ),
      ),
    );
  }
}
