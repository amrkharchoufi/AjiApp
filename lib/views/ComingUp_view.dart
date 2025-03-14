import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/matches_widget.dart';
import 'package:ajiapp/widgets/service_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class ComingUp extends StatefulWidget {
  const ComingUp({super.key});

  @override
  State<ComingUp> createState() => _ComingUpState();
}

class _ComingUpState extends State<ComingUp> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: ajired,
                size: ScreenSize.width / 13,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.account_circle_outlined,
                color: ajired,
                size: ScreenSize.width / 12,
              ),
            ),
          ],
        ),
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
                ServiceNameWidget(name: "Coming Up"),
                SizedBox(
                  height: ScreenSize.height / 60,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: ScreenSize.width / 25),
                  child: Column(
                    children: [
                      Matchwidget(
                          width: ScreenSize.width,
                          height: ScreenSize.height / 4,
                          ImagePath: "assets/images/match.jpg",
                          MatchTitle: "Morocco vs\nZambia",
                          MatchDate: "16 December at 18:00",
                          Matchplace: "Sport Complexe Prince",
                          Price: "600"),
                      SizedBox(
                        height: ScreenSize.width / 20,
                      ),
                      Matchwidget(
                          width: ScreenSize.width,
                          height: ScreenSize.height / 4,
                          ImagePath: "assets/images/match2.jpg",
                          MatchTitle: "Tunisia vs\nSouth Africa",
                          MatchDate: "16 December at 18:00",
                          Matchplace: "Sport Complexe Prince",
                          Price: "600"),
                      SizedBox(
                        height: ScreenSize.width / 20,
                      ),
                      Matchwidget(
                          width: ScreenSize.width,
                          height: ScreenSize.height / 4,
                          ImagePath: "assets/images/match2.jpg",
                          MatchTitle: "Tunisia vs\nSouth Africa",
                          MatchDate: "16 December at 18:00",
                          Matchplace: "Sport Complexe Prince",
                          Price: "600"),
                      SizedBox(
                        height: ScreenSize.width / 20,
                      ),
                      Matchwidget(
                          width: ScreenSize.width,
                          height: ScreenSize.height / 4,
                          ImagePath: "assets/images/match2.jpg",
                          MatchTitle: "Tunisia vs\nSouth Africa",
                          MatchDate: "16 December at 18:00",
                          Matchplace: "Sport Complexe Prince",
                          Price: "600"),
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
