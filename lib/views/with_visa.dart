import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class WithVisa extends StatefulWidget {
  final String country;
  const WithVisa({super.key, required this.country});

  @override
  State<WithVisa> createState() => _WithVisaState();
}

class _WithVisaState extends State<WithVisa> {
  final Map<String, String> nationalitiesMap = {
    "Algeria": "Algerian",
    "Benin": "Beninese",
    "Cameroon": "Cameroonian",
    "Egypt": "Egyptian",
    "Ghana": "Ghanaian",
    "Ivory Coast": "Ivorian",
    "Morocco": "Moroccan",
    "Senegal": "Senegalese",
  };

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
                Stack(
                  children: [
                    Image.asset(
                      "assets/images/shape.png",
                      width: ScreenSize.width,
                      fit: BoxFit.fitWidth,
                    ),
                    Positioned(
                      left: ScreenSize.width / 20,
                      top: ScreenSize.height / 20,
                      child: Row(
                        children: [
                          Image(
                            image: Svg("assets/images/logowhite.svg"),
                          ),
                          SizedBox(
                            width: ScreenSize.width / 25,
                          ),
                          Text(
                            "Visa",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenSize.width / 13.5,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenSize.height / 120,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: ScreenSize.height / 60),
                  child: Row(
                    children: [
                      Image(
                        image: Svg("assets/icons/${widget.country}_icon.svg"),
                        width: ScreenSize.width / 4.5,
                        height: ScreenSize.width / 4.5,
                      ),
                      SizedBox(
                        width: ScreenSize.width / 30,
                      ),
                      Text(
                        widget.country,
                        style: TextStyle(
                            fontFamily: "SFDisplay",
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
                        "if you hold a ${nationalitiesMap[widget.country]} passport,you are required to obtain an eVisa or eTA to enter Morocco",
                        style: TextStyle(
                            fontFamily: "SFDisplay",
                            fontSize: ScreenSize.width / 21,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Moroccan embassies and consulates handle visa applications for foreign nationals who wish to visit Morocco for various purposes, including tourism, work, study, business, or family visits.",
                        style: TextStyle(
                          fontFamily: "SFDisplay",
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
                    backgroundColor: gold,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.width / 15,
                      vertical: ScreenSize.width / 40,
                    ),
                  ),
                  child: Text(
                    "Apply for eVisa",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: (ScreenSize.width / 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
