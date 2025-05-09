import 'package:ajiapp/services/common/Map_view.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';
import '../../widgets/featured_section.dart';
import '../../widgets/delivery_section.dart';
import '../../widgets/restaurant_section.dart';

class FoodHomePage extends StatelessWidget {
  const FoodHomePage({super.key});

  void _showMapBottomSheet(BuildContext context) {
    // Use a fixed-size bottom sheet instead of a draggable one
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      // Disable the default bottom sheet drag to prevent gesture conflicts
      enableDrag: false,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            // Custom handle bar with manual drag detection
            GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity! > 300) {
                  // If swiped down with enough velocity, close the sheet
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                width: double.infinity,
                color: Colors.transparent,
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Column(
                  children: [
                    // Handle indicator
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Map View",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Divider(thickness: 1),

            // Map area - this will contain the map that can be interacted with
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  // Make sure the map is wrapped to properly handle its own gestures
                  child: const MapView(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showMapBottomSheet(context),
          label: const Text("View on Map"),
          icon: const Icon(Icons.map),
        ),
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
              SingleChildScrollView(
                child: Column(
                  children: [
                    MyappbarWidget(
                      title: "Food",
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FeaturedSection(),
                          DeliverySection(),
                          RestaurantSection(),
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: Text("Version 1.1.2",
                                  style: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              MyappbarWidget(
                title: "Food",
              ),
            ],
          ),
        ));
  }
}
