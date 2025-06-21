import 'package:ajiapp/services/followyourteam_service/controller/team_details_controller.dart';
import 'package:ajiapp/services/followyourteam_service/model/fixture_model.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/football_standings_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TeamDetailsView extends StatelessWidget {
  const TeamDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final TeamDetailsController controller = Get.put(TeamDetailsController());

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
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      MyappbarWidget(title: "Follow Your Team"),
                      Container(
                        margin: EdgeInsets.all(20),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(50),
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(50),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      offset: Offset(0, 1),
                                    ),
                                  ]),
                              child: Column(
                                spacing: 10,
                                children: [
                                  matchWidget(controller.fixture),
                                  customDivider(),
                                  stadiumWidget([
                                    "https://www.hok.com/wp-content/uploads/2023/06/2023_0607_StadiumoftheFutureRendering-2_1900.jpg"
                                  ]),
                                  customDivider(),
                                  Obx(
                                    () => tabs(
                                      currentIndex: controller.tabIndex.value,
                                      onPressed: (index) {
                                        controller.changeTabIndex(index);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              margin: EdgeInsets.only(top: 10),
                              child: Obx(
                                () => controller.tabIndex.value == 0
                                    ? FootballStandingsWidget()
                                    : SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            "The line up will be displayed once it is available.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            //book ur ticket button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Handle button press
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ajired,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      "Book Your Ticket",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.getBlockSizeHorizontal(
                                                4),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                MyappbarWidget(title: "Follow Your Team"),
              ],
            ),
          )),
    );
  }

  Widget customDivider() {
    return Center(
      child: Container(
        height: 2,
        width: Get.width * 0.4,
        decoration: BoxDecoration(
            color: ajired, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget team(TeamSimple team) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          width: SizeConfig.getBlockSizeHorizontal(15),
          height: SizeConfig.getBlockSizeHorizontal(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: CachedNetworkImage(
            imageUrl: team.logo,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 2),
        Text(
          team.name,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeConfig.getBlockSizeHorizontal(3.5),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget matchWidget(FixtureSimple fixture) {
    DateTime matchDate = DateTime.parse(fixture.date);
    String dayAndDate = DateFormat('EEEE MMM d').format(matchDate);
    String time = DateFormat('hh:mm a').format(matchDate);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          team(fixture.homeTeam),
          Expanded(
            child: Column(
              children: [
                Text(
                  dayAndDate,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.getBlockSizeHorizontal(4),
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  time,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: SizeConfig.getBlockSizeHorizontal(3),
                      color: Colors.black54,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Vs",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: SizeConfig.getBlockSizeHorizontal(4),
                      color: ajired,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          team(fixture.awayTeam),
        ],
      ),
    );
  }

  Widget stadiumWidget(List<String> images) {
    CarouselSliderController carouselSliderController =
        CarouselSliderController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("Playing in:"),
        ),
        SizedBox(
          width: Get.width,
          child: Stack(
            children: [
              CarouselSlider(
                carouselController: carouselSliderController,
                options: CarouselOptions(height: 200.0, viewportFraction: 1),
                items: images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return CachedNetworkImage(
                        imageUrl: i,
                        fit: BoxFit.cover,
                      );
                    },
                  );
                }).toList(),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  onPressed: () {
                    carouselSliderController.nextPage();
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  onPressed: () {
                    carouselSliderController.previousPage();
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black])),
                    child: Column(
                      children: [
                        Text(
                          "Prince Moulay Abdellah Stadium",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                                size: 16,
                              ),
                              Text(
                                "Rabat",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }

  Widget tabs({
    required int currentIndex,
    required Function(int index) onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () => onPressed(0),
          child: Text(
            "Standing",
            style: TextStyle(
                color: currentIndex == 0 ? ajired : Colors.grey,
                fontSize: SizeConfig.getBlockSizeHorizontal(5),
                fontWeight: FontWeight.w700),
          ),
        ),
        TextButton(
          onPressed: () => onPressed(1),
          child: Text(
            "Line Up",
            style: TextStyle(
                color: currentIndex == 1 ? ajired : Colors.grey,
                fontSize: SizeConfig.getBlockSizeHorizontal(5),
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
