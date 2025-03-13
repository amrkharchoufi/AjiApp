import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class VisitMoroccoCard2 extends StatelessWidget {
  final String ImagePath;
  final String siteName;
  final String sitePlace;
  final String duree;
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
      required this.price});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Container(
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 0.5, color: gold),
      ),
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
                  ),
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
                        Icon(
                          Icons.hourglass_empty,
                          size: 23,
                          color: Colors.black,
                        ),
                        Text(
                          duree,
                          style: TextStyle(
                            fontFamily: "SFDisplay",
                            color: Colors.black,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 23,
                          color: Colors.black,
                        ),
                        Text(
                          sitePlace,
                          style: TextStyle(
                            fontFamily: "SFDisplay",
                            color: Colors.black,
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
                          ),
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
                          ),
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
                  ),
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
                          color: const Color.fromARGB(255, 28, 73, 29),
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenSize.width / 15),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ajired,
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
                          color: Colors.white,
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
