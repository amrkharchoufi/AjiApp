import 'package:ajiapp/routing.dart';
import 'package:ajiapp/services/visa_service/controller/visa_conrtoller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WithoutVisaView extends StatelessWidget {
  const WithoutVisaView({super.key});

  @override
  Widget build(BuildContext context) {
    final VisaConrtoller controller = Get.put(VisaConrtoller());
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
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            MyappbarWidget(
              title: "Visa",
            ),
            SizedBox(
              height: ScreenSize.height / 120,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize.height / 60),
              child: Row(
                children: [
                  SvgPicture.network(
                    controller.selectedvisa.Imageurl,
                    width: ScreenSize.width / 4.5,
                    height: ScreenSize.width / 4.5,
                  ),
                  SizedBox(
                    width: ScreenSize.width / 30,
                  ),
                  Text(
                    controller.selectedvisa.country,
                    style: TextStyle(
                        fontSize: ScreenSize.width / 11,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenSize.height / 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: ScreenSize.width / 20,
                  ),
                  Text(
                    "You do not need a visa to travel to Morocco. ",
                    style: TextStyle(
                        fontSize: ScreenSize.width / 21,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: ScreenSize.width / 20,
                  ),
                  Text(
                    "You can book your flight directly. ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: ScreenSize.width / 25,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenSize.width / 4,
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.VISIT_MOROCCO);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ajired,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                fixedSize: Size(
                  ScreenSize.width / 1.5,
                  ScreenSize.height / 18,
                ),
              ),
              child: Text(
                "Visit Morocco",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (ScreenSize.width / 20),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
