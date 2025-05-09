import 'package:ajiapp/routing.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/service_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesWidget extends StatelessWidget {
  final double? rownb;
  const ServicesWidget({super.key, this.rownb});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Widget> Services = [
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.VISIT_MOROCCO);
        },
        child: ServiceWidget(
          golden: false,
          width: ScreenSize.width / 3.7,
          height: ScreenSize.width / 3.7,
          text: "Visit Morocco",
          customzie: SizeConfig.getBlockSizeHorizontal(6),
          img: "assets/icons/visit_icon.svg",
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.VISA);
        },
        child: ServiceWidget(
          golden: false,
          width: ScreenSize.width / 3.7,
          height: ScreenSize.width / 3.7,
          text: "Visa",
          img: "assets/icons/visa_icon.svg",
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.FOLLOWYOURTEAM);
        },
        child: ServiceWidget(
          golden: false,
          width: ScreenSize.width / 3.7,
          height: ScreenSize.width / 3.7,
          text: "Your team",
          img: "assets/icons/ball_icon.svg",
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.ESIM);
        },
        child: ServiceWidget(
          golden: false,
          width: ScreenSize.width / 3.7,
          height: ScreenSize.width / 3.7,
          text: "E-sim",
          img: "assets/icons/Phone.svg",
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.ACCOMMODATION);
        },
        child: ServiceWidget(
          golden: false,
          width: ScreenSize.width / 3.7,
          height: ScreenSize.width / 3.7,
          text: "Hotels",
          img: "assets/icons/hotelicon.svg",
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.CONTACTS);
        },
        child: ServiceWidget(
          golden: false,
          width: ScreenSize.width / 3.7,
          height: ScreenSize.width / 3.7,
          text: "Contacts",
          img: "assets/icons/contact_icon.svg",
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.FOOD);
        },
        child: ServiceWidget(
          golden: false,
          width: ScreenSize.width / 3.7,
          height: ScreenSize.width / 3.7,
          text: "Food",
          customzie: SizeConfig.getBlockSizeHorizontal(9.5),
          img: "assets/icons/food.svg",
        ),
      ),
      GestureDetector(
          onTap: () {
            Get.toNamed(Routes.TICKETS);
          },
          child: ServiceWidget(
            golden: false,
            width: ScreenSize.width / 3.7,
            height: ScreenSize.width / 3.7,
            text: "Tickets",
            customzie: SizeConfig.getBlockSizeHorizontal(9),
            img: "assets/icons/ticket_icon.svg",
          )),
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.TRANSPORTATION);
        },
        child: ServiceWidget(
            golden: false,
            width: ScreenSize.width / 3.7,
            height: ScreenSize.width / 3.7,
            text: "Transportation",
            customzie: SizeConfig.getBlockSizeHorizontal(9),
            img: "assets/icons/car_icon.svg"),
      ),
    ];
    return FadeInUp(
      duration: Duration(milliseconds: 1600),
      child: Wrap(
          direction: Axis.horizontal,
          spacing: ScreenSize.width / 25,
          runSpacing: ScreenSize.width / 25,
          children: [
            for (int i = 0; i < rownb! * 3; i++) ...[
              Services[i],
            ]
          ]),
    );
  }
}
