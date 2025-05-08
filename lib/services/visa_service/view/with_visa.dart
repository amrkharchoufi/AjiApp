import 'package:ajiapp/services/visa_service/controller/visa_conrtoller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WithVisa extends StatelessWidget {
  const WithVisa({super.key});

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
            child: Column(
              children: [
                MyappbarWidget(
                  title: "Visa",
                ),
                SizedBox(
                  height: ScreenSize.height / 120,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: ScreenSize.height / 60),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/${controller.selectedNationality}_icon.svg",
                        width: ScreenSize.width / 4.5,
                        height: ScreenSize.width / 4.5,
                      ),
                      SizedBox(
                        width: ScreenSize.width / 30,
                      ),
                      Text(
                        controller.selectedNationality,
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
                    children: [
                      Text(
                        "if you hold a ${controller.nationalitiesMap[controller.selectedNationality]} passport,you are required to obtain an eVisa or eTA to enter Morocco",
                        style: TextStyle(
                            
                            fontSize: ScreenSize.width / 21,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Moroccan embassies and consulates handle visa applications for foreign nationals who wish to visit Morocco for various purposes, including tourism, work, study, business, or family visits.",
                        style: TextStyle(
                          
                          fontSize: ScreenSize.width / 25,
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.width / 10,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                        onPressed: () {},
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
                          "Apply for e-visa",
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
