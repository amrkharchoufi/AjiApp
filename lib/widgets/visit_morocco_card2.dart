import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class VisitMoroccoCard2 extends StatelessWidget {
  final String ImagePath;
  final String siteName;
  final String sitePlace;
  final String duree;
  final bool designred;
  final String rating;
  final double width;
  final double height;
  final String price;
  final String ratingsize;
  final String Description;
  const VisitMoroccoCard2(
      {super.key,
      required this.ImagePath,
      required this.siteName,
      required this.sitePlace,
      required this.rating,
      required this.width,
      required this.height,
      required this.ratingsize,
      required this.Description,
      required this.duree,
      required this.price,
      required this.designred});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Container(
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: !designred ? Colors.white : ajired,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 0.5, color: gold),
          image: designred
              ? DecorationImage(
                  image: AssetImage("assets/images/design.png"),
                  alignment: Alignment.bottomRight,
                  scale: 0.7)
              : null),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width,
            height: height / 2.5,
            child: Image.asset(
              ImagePath,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              width: width,
              height: height / 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.width / 30,
                vertical: ScreenSize.width / 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  siteName,
                  softWrap: true,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "SFDisplay",
                      fontSize: ScreenSize.width / 20,
                      fontWeight: FontWeight.bold,
                      color: designred ? Colors.white : Colors.black),
                ),
                SizedBox(
                  height: ScreenSize.width / 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.hourglass_empty,
                            size: 23,
                            color: designred ? Colors.white : Colors.black),
                        Text(
                          duree,
                          style: TextStyle(
                              fontFamily: "SFDisplay",
                              fontSize: ScreenSize.width / 25,
                              fontWeight: FontWeight.bold,
                              color: designred ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: ScreenSize.width / 50,
                    ),
                    Text(
                      "|",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenSize.width / 20),
                    ),
                    SizedBox(
                      width: ScreenSize.width / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 23,
                            color: designred ? Colors.white : Colors.black),
                        Text(
                          sitePlace,
                          style: TextStyle(
                            fontFamily: "SFDisplay",
                            color: designred ? Colors.white : Colors.black,
                            fontSize: ScreenSize.width / 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: ScreenSize.width / 50,
                    ),
                    Text(
                      "|",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenSize.width / 20),
                    ),
                    SizedBox(
                      width: ScreenSize.width / 50,
                    ),
                    Row(
                      children: [
                        Text(
                          rating,
                          style: TextStyle(
                              fontFamily: "SFDisplay",
                              fontSize: ScreenSize.width / 25,
                              fontWeight: FontWeight.bold,
                              color: designred ? Colors.white : Colors.black),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          "($ratingsize)",
                          style: TextStyle(
                              fontFamily: "SFDisplay",
                              fontSize: ScreenSize.width / 30,
                              color: designred ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenSize.width / 40,
                ),
                Text(
                  Description,
                  softWrap: true,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "SFDisplay",
                      fontSize: ScreenSize.width / 35,
                      fontWeight: FontWeight.bold,
                      color: designred ? Colors.white : Colors.black),
                ),
                SizedBox(
                  height: ScreenSize.width / 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                          color: !designred
                              ? Color.fromARGB(255, 28, 73, 29)
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenSize.width / 15),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !designred ? ajired : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenSize.width / 12,
                        ),
                      ),
                      child: Text(
                        "Read More",
                        style: TextStyle(
                          color: designred ? ajired : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: (ScreenSize.width / 22),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
