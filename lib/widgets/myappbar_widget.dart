import 'package:ajiapp/services/home/controller/home_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/service_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyappbarWidget extends StatelessWidget {
  final String title;
  const MyappbarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Column(
      children: [
        AppBar(
          backgroundColor: ajired,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              onPressed: () => controller.checklogin(context, 1),
              icon: Icon(Icons.notifications_outlined,
                  size: ScreenSize.width / 12),
            ),
            IconButton(
              onPressed: () => controller.checklogin(context, 0),
              icon: Icon(Icons.account_circle_outlined,
                  size: ScreenSize.width / 12),
            ),
          ],
        ),
        ServiceNameWidget(name: title)
      ],
    );
  }
}
