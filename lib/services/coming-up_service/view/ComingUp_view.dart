import 'package:ajiapp/services/coming-up_service/controller/comingup_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/matches_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComingUp extends StatelessWidget {
  ComingUp({super.key});
  final ComingupController controller = Get.put(ComingupController());
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
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                MyappbarWidget(
                  title: "Coming Up",
                ),
                SizedBox(
                  height: ScreenSize.height / 60,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: ScreenSize.width / 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: ScreenSize.width / 20,
                    children: [
                      Text(
                        "Events",
                        style: TextStyle(
                          fontSize: ScreenSize.width / 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(color: ajired),
                          );
                        } else if (controller.events.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.hotel, size: 64, color: ajired),
                                const SizedBox(height: 16),
                                const Text("No Events available",
                                    style: TextStyle(fontSize: 18)),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: () => controller.fetchEvents(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ajired,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text("Refresh"),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Column(
                            spacing: ScreenSize.height / 60,
                            children: controller.events.map((event) {
                              return Matchwidget(
                                width: ScreenSize.width,
                                height: ScreenSize.height / 4,
                                ImagePath: event.imageUrl,
                                MatchTitleaway: event.awayteam,
                                MatchTitlehome: event.hometeam,
                                MatchDate:
                                    "${event.matchDate} \n${event.matchTime}",
                                Matchplace: event.venue,
                              );
                            }).toList(),
                          );
                        }
                      }),
                      SizedBox(
                        height: ScreenSize.height / 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          MyappbarWidget(
            title: "Coming Up",
          ),
        ],
      ),
    ));
  }
}
