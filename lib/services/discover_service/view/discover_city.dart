import 'package:ajiapp/services/discover_service/view/discover_visit_morroco_version.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';

class DiscovercityView extends StatelessWidget {
  final String city;
  const DiscovercityView({super.key, this.city = "All the Country"});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      body: Container(
        width: ScreenSize.width,
        height: ScreenSize.height,
        decoration: const BoxDecoration(
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
                  const MyappbarWidget(title: "Visit Morocco"),
                  Column(
                    children: [
                      VisitMoroccoCity(
                        city: city,
                      )
                    ],
                  ),
                  SizedBox(height: ScreenSize.height / 60),
                ],
              ),
            ),
            // Fixed app bar at the top
            const MyappbarWidget(title: "Visit Morocco"),
          ],
        ),
      ),
    );
  }
}
