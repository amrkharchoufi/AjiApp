import 'package:ajiapp/services/followyourteam_service/controller/fixture_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class StadiumDetailsView extends StatelessWidget {
  StadiumDetailsView({super.key});
  final FixtureController controller = Get.put(FixtureController());
  CarouselSliderController carouselSliderController =
      CarouselSliderController();

  Future<void> _openInMaps() async {
    if (controller.selectedstd.latitude == 0 ||
        controller.selectedstd.longitude == 0) {
      return;
    }

    final url =
        'https://www.google.com/maps/search/?api=1&query=${controller.selectedstd.latitude},${controller.selectedstd.longitude}';

    // ignore: deprecated_member_use
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
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
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                MyappbarWidget(
                  title: "Stadiums",
                ),
                Padding(
                  padding: EdgeInsets.all(SizeConfig.getBlockSizeHorizontal(5)),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.getBlockSizeVertical(1.5)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(17)),
                    child: Column(
                      spacing: SizeConfig.getBlockSizeVertical(1.5),
                      children: [
                        Text(
                          controller.selectedstd.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.getBlockSizeHorizontal(6)),
                        ),
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          width: Get.width,
                          child: Stack(
                            children: [
                              CarouselSlider(
                                carouselController: carouselSliderController,
                                options: CarouselOptions(
                                    height:
                                        SizeConfig.getBlockSizeHorizontal(68),
                                    viewportFraction: 1),
                                items:
                                    [controller.selectedstd.imageUrl].map((i) {
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
                                        border: Border.all(
                                            color: Colors.white, width: 2),
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
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.getBlockSizeHorizontal(5)),
                          child: Column(
                            spacing: SizeConfig.getBlockSizeVertical(1.5),
                            children: [
                              Row(
                                spacing: SizeConfig.getBlockSizeHorizontal(5),
                                children: [
                                  Column(
                                    spacing:
                                        SizeConfig.getBlockSizeVertical(1.5),
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Location:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeConfig
                                                .getBlockSizeHorizontal(3.5)),
                                      ),
                                      Text(
                                        "Capacity:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeConfig
                                                .getBlockSizeHorizontal(3.5)),
                                      ),
                                      Text(
                                        "Inauguration:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeConfig
                                                .getBlockSizeHorizontal(3.5)),
                                      ),
                                      Text(
                                        "Home ground for:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeConfig
                                                .getBlockSizeHorizontal(3.5)),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    child: Column(
                                      spacing:
                                          SizeConfig.getBlockSizeVertical(1.5),
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.selectedstd.city,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: SizeConfig
                                                  .getBlockSizeHorizontal(3.5)),
                                        ),
                                        Text(controller.selectedstd.capacity,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: SizeConfig
                                                    .getBlockSizeHorizontal(
                                                        3.5))),
                                        Text(
                                            controller.selectedstd.inauguration,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: SizeConfig
                                                    .getBlockSizeHorizontal(
                                                        3.5))),
                                        Text(
                                            controller
                                                .selectedstd.homeGroundFor,
                                            softWrap: true,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: SizeConfig
                                                    .getBlockSizeHorizontal(
                                                        3.5)))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "About Stadium",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            SizeConfig.getBlockSizeHorizontal(
                                                6)),
                                  ),
                                ],
                              ),
                              Text(controller.selectedstd.description),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MaterialButton(
                                    onPressed: _openInMaps,
                                    color: ajired,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minWidth:
                                        SizeConfig.getBlockSizeHorizontal(35),
                                    height: SizeConfig.getBlockSizeVertical(3),
                                    child: Text(
                                      "View on map",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.getBlockSizeHorizontal(
                                                3.5),
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
                ),
              ],
            ),
          ),
          MyappbarWidget(
            title: "Stadiums",
          ),
        ],
      ),
    ));
  }
}
