import 'package:ajiapp/services/tourisme_service/controller/Tourisme_controller.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/filter_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitMorrocoView extends StatelessWidget {
  const VisitMorrocoView({super.key});

  @override
  Widget build(BuildContext context) {
    final TourismeController controller = Get.put(TourismeController());
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
                  title: "Visit Morocco",
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenSize.height / 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ExpandableFilterWidget(
                            CitySelected: (String? city) {
                              controller.searchCity(city!);
                            },
                            InterestSelected: (String? city) {},
                          ),
                        ],
                      ),
                    ),
                    GetBuilder(
                      init: TourismeController(),
                      builder: (controller) {
                        return controller.custom;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenSize.height / 60,
                ),
              ],
            ),
          ),
          MyappbarWidget(
            title: "Visit Morocco",
          ),
        ],
      ),
    ));
  }
}