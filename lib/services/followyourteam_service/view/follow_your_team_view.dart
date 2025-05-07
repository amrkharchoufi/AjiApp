import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/services/followyourteam_service/controller/fixture_controller.dart';
import 'package:ajiapp/widgets/match_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:ajiapp/widgets/searchbar.dart';
import 'package:ajiapp/widgets/stadium_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowYourTeamView extends StatelessWidget {
  const FollowYourTeamView({super.key});

  @override
  Widget build(BuildContext context) {
    final FixtureController controller = Get.put(FixtureController());
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
                spacing: ScreenSize.height / 70,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyappbarWidget(title: "Follow Your Team"),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          spreadRadius: 1,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Obx(() {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.onchanged();
                              },
                              child: Container(
                                height: 30,
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: controller.selectedIndex.value
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Text(
                                    "Teams",
                                    style: TextStyle(
                                      color: controller.selectedIndex.value
                                          ? ajired
                                          : Colors.grey,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        Spacer(),
                        Obx(() {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.onchanged();
                              },
                              child: Container(
                                height: 30,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: controller.selectedIndex.value
                                      ? Colors.transparent
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Text(
                                    "Stadiums",
                                    style: TextStyle(
                                      color: controller.selectedIndex.value
                                          ? Colors.grey
                                          : ajired,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Obx(() {
                    return SizedBox(
                      width: ScreenSize.width / 1.4,
                      height: 52,
                      child: controller.selectedIndex.value
                          ? SearchbarWidget(
                              options: controller.teamsnames,
                              onchanged: (value) {
                                controller.searchTeam(value!);
                              },
                              placeholder: "Search your team",
                            )
                          : SearchbarWidget(
                              options: controller.stadiums,
                              onchanged: (value) {
                                controller.searchTeam(value!);
                              },
                              placeholder: "Search Stadium",
                            ),
                    );
                  }),
                  Row(
                    children: [
                      Obx((){
                        return Padding(
                          padding: EdgeInsets.only(left: ScreenSize.width / 20),
                          child: Text(
                            controller.selectedIndex.value
                                ? "Upcoming"
                                : "Stadiums",
                            style: TextStyle(
                              fontSize: ScreenSize.width / 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (controller.error.isNotEmpty) {
                      return Center(child: Text(controller.error.value));
                    } else {
                      return controller.selectedIndex.value
                          ? Column(
                              children: controller.fixtures.map((fixture) {
                                return MatchWidget(
                                  fixture: fixture,
                                );
                              }).toList(),
                            )
                          : Column(
                              children:  controller.stadiumsinfo.map((stadium) {
                                return StadiumWidget(
                                  ImagePath: stadium.imageUrl!,
                                  MatchTitleaway: stadium.name!, 
                                  Matchplace: stadium.city!,
                                  width:  ScreenSize.width,
                                  height:   ScreenSize.height / 6,
                                  
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
