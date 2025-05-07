import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/services/tourisme_service/visit_morocco_all.dart';
import 'package:ajiapp/services/tourisme_service/visit_morocco_home.dart';
import 'package:ajiapp/services/tourisme_service/visit_morroco_city.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:ajiapp/widgets/searchbar.dart';
import 'package:flutter/material.dart';

class VisitMorrocoView extends StatefulWidget {
  const VisitMorrocoView({super.key});

  @override
  State<VisitMorrocoView> createState() => _VisitMorrocoViewState();
}

class _VisitMorrocoViewState extends State<VisitMorrocoView> {
  final List<String> cities = [
    "All the Country",
    "Rabat",
    "Marrakech ",
    "Casanlanca",
    "Tangier",
    "Fes",
    "Essaouira",
  ];
  Widget Custom = VisitMoroccoHome();

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
          ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MyappbarWidget(
                    title: "Visit Morocco",
                  ),
                  SizedBox(
                    height: ScreenSize.height / 120,
                  ),
                  Padding(
                    padding: EdgeInsets.all(ScreenSize.height / 60),
                    child: Column(
                      children: [
                        SizedBox(
                          width: ScreenSize.width / 1.2,
                          child: SearchbarWidget(
                            placeholder: "where do you want to go?",
                              options: cities,
                              onchanged: (value) {
                                if (value == "All the Country") {
                                  setState(() {
                                    Custom = VisitMoroccoAll();
                                  });
                                } else {
                                  setState(() {
                                    Custom = VisitMoroccoCity(city: value!);
                                  });
                                }
                              }),
                        ),
                        SizedBox(
                          height: ScreenSize.width / 20,
                        ),
                        Custom
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          MyappbarWidget(
            title: "Visit Morocco",
          ),
        ],
      ),
    ));
  }
}
