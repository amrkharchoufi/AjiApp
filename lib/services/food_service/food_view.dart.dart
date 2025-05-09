import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';
import '../../widgets/featured_section.dart';
import '../../widgets/delivery_section.dart';
import '../../widgets/restaurant_section.dart';

class FoodHomePage extends StatelessWidget {
  const FoodHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
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
