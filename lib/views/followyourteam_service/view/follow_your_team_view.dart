import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/followyourteam_service/controller/fixture_controller.dart';
import 'package:ajiapp/widgets/match_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowYourTeamView extends StatelessWidget {
  FollowYourTeamView({super.key});
  final FixtureController controller = Get.put(FixtureController());

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyappbarWidget(title: "Follow Your Team"),
                  
                  Padding(
                    padding:  EdgeInsets.only(left: ScreenSize.width / 20),
                    child: Text(
                      "Upcoming",
                      style: TextStyle(
                        fontSize: ScreenSize.height / 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (controller.error.isNotEmpty) {
                      return Center(child: Text(controller.error.value));
                    } else {
                      return Column(
                        children: controller.fixtures.map((fixture) {
                          return MatchWidget(
                            fixture: fixture,
                          );
                        }).toList(),
                      );
                    }
                  }),
                ],
              ),
            ),
            MyappbarWidget(title: "Follow Your Team"),
          ],
        ),
      ),
    );
  }
}
