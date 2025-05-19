import 'package:ajiapp/services/accomodation_service/controller/hotel_controller.dart';
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
        child:
            Stack(
              children: [
                Obx(() {
                  if (controller.isloading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SingleChildScrollView(
                    
                      child: Column(
                        spacing: ScreenSize.width/20,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyappbarWidget(title: "Hotels"),
                          SectionHeader(title: "Recommanded"),
                          ...controller.hotels.map(
                            (hotel) => HotelWidget(hotel: hotel),
                          ),
                          SizedBox(height: 20), // For padding at bottom
                        ],
                      ),
                    );
                  }
                }),
                MyappbarWidget(title: "Hotels"),
              ],
            ),
            
      
      ),
    );
  }
}
