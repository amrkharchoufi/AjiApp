import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/discover_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:ajiapp/widgets/service_name_widget.dart';
import 'package:flutter/material.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
        appBar: MyappbarWidget(),
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
                ServiceNameWidget(name: "Discover"),
                SizedBox(
                  height: ScreenSize.height / 60,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: ScreenSize.width / 25),
                  child: Column(
                    children: [
                      DiscoverCard(
                          ImagePath: "assets/images/city1.png",
                          siteName: "Mausoluem of Hassan",
                          sitePlace: "Rabat",
                          Entry: "Paid Entry",
                          width: ScreenSize.width,
                          height: ScreenSize.height / 4.5),
                      SizedBox(
                        height: ScreenSize.height / 60,
                      ),
                      DiscoverCard(
                          ImagePath: "assets/images/city2.png",
                          siteName: "Hassan Tower",
                          sitePlace: "Rabat",
                          Entry: "Free Entry",
                          width: ScreenSize.width,
                          height: ScreenSize.height / 4.5),
                      SizedBox(
                        height: ScreenSize.height / 60,
                      ),
                      DiscoverCard(
                          ImagePath: "assets/images/hercules.png",
                          siteName: "Hercules Caves",
                          sitePlace: "Tangier",
                          Entry: "Free Entry",
                          width: ScreenSize.width,
                          height: ScreenSize.height / 4.5),
                      SizedBox(
                        height: ScreenSize.height / 60,
                      ),
                      DiscoverCard(
                          ImagePath: "assets/images/mosque.jpg",
                          siteName: "Medina of Fez",
                          sitePlace: "Fez",
                          Entry: "Paid Entry",
                          width: ScreenSize.width,
                          height: ScreenSize.height / 4.5),
                      SizedBox(
                        height: ScreenSize.height / 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
