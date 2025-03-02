import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class AvailableSoon extends StatelessWidget {
  const AvailableSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.width / 20,
                    vertical: ScreenSize.height / 30),
                width: double.infinity,
                height: ScreenSize.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover)),
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            "assets/images/logoaji.png",
                            scale: 0.75,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Hello,",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/notifications.png",
                            scale: 0.75,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/images/map.png",
                            scale: 0.75,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/images/EN.png",
                            scale: 0.75,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/images/profile.png",
                            scale: 0.75,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenSize.height / 3,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(width: 1, color: gold),
                    ),
                    child: Text(
                      "Available Soon",
                      style: TextStyle(
                          color: ajired,
                          fontFamily: "SFDisplay",
                          fontSize: ScreenSize.width / 10),
                    ),
                  )
                ]))));
  }
}
