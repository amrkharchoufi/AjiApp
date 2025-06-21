import 'package:ajiapp/services/visa_service/controller/visa_conrtoller.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:ajiapp/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisaView extends StatelessWidget {
  const VisaView({super.key});

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
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Padding(
                  padding: EdgeInsets.all(ScreenSize.height / 60),
                  child: Column(
                    children: [
                      Text(
                        "Get visa information before your next trip to Morroco",
                        style: TextStyle(
                            fontSize: ScreenSize.width / 21,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Search your nationality to find out the documents you need for your visa application",
                        style: TextStyle(
                          fontSize: ScreenSize.width / 25,
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.width / 10,
                      ),
                      SizedBox(
                          width: ScreenSize.width / 1.2,
                          child: SearchbarWidget(
                              placeholder: "Search your nationality",
                              options: controller.nationalities,
                              onchanged: (value) {
                                controller.searchNationality(value!);
                              }))
                    ],
                  ),
                );
              }
            })
          ],
        ),
      ),
    ));
  }
}
