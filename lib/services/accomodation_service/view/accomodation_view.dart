import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:ajiapp/widgets/section_header.dart';
import 'package:flutter/material.dart';

class AccomodationView extends StatefulWidget {
  const AccomodationView({super.key});

  @override
  State<AccomodationView> createState() => _AccomodationViewState();
}

class _AccomodationViewState extends State<AccomodationView> {
  final List<String> cities = [
    "Rabat",
    "Sale",
    "Casablanca",
    "Marrakech",
  ];

  @override
  Widget build(BuildContext context) {
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
              children: [
                MyappbarWidget(
                  title: "Hotels",
                ),
                SizedBox(
                  height: ScreenSize.height / 120,
                ),
                Column(children: [SectionHeader(title: "Recommanded")]),
              ],
            ),
          ),
          MyappbarWidget(
            title: "Hotels",
          ),
        ],
      ),
    ));
  }
}
