import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/matches_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';

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
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                MyappbarWidget(
                  title: "Coming Up",
                ),
                SizedBox(
                  height: ScreenSize.height / 60,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: ScreenSize.width / 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: ScreenSize.width / 20,
                    children: [
                      Text(
                        "Football",
                        style: TextStyle(
                          fontSize: ScreenSize.width / 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Matchwidget(
                          width: ScreenSize.width,
                          height: ScreenSize.height / 4,
                          ImagePath: "assets/images/upcomingpic2.jpg",
                          MatchTitleaway: "Zambia",
                          MatchTitlehome: "Mali",
                          MatchDate: "Sunday, Dec 21 \n18:00",
                          Matchplace: "Sport Complexe Prince",
                          Price: "600"),
                      Matchwidget(
                          width: ScreenSize.width,
                          height: ScreenSize.height / 4,
                          ImagePath: "assets/images/upcomingpic1.jpg",
                          MatchTitleaway: "Comoros",
                          MatchTitlehome: "Morocco",
                          MatchDate: "Sunday, Dec 21 \n18:00",
                          Matchplace: "Sport Complexe Prince",
                          Price: "600"),
                      Matchwidget(
                          width: ScreenSize.width,
                          height: ScreenSize.height / 4,
                          ImagePath: "assets/images/upcomingpic2.jpg",
                          MatchTitleaway: "Zambia",
                          MatchTitlehome: "Mali",
                          MatchDate: "Sunday, Dec 21 \n18:00",
                          Matchplace: "Sport Complexe Prince",
                          Price: "600"),
                      Matchwidget(
                          width: ScreenSize.width,
                          height: ScreenSize.height / 4,
                          ImagePath: "assets/images/upcomingpic1.jpg",
                          MatchTitleaway: "Comoros",
                          MatchTitlehome: "Morocco",
                          MatchDate: "Sunday, Dec 21 \n18:00",
                          Matchplace: "Sport Complexe Prince",
                          Price: "600"),
                      SizedBox(
                        height: ScreenSize.height / 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          MyappbarWidget(
            title: "Coming Up",
          ),
        ],
      ),
    ));
  }
}
