import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class VisitMorrocoCard1 extends StatelessWidget {
  final String ImagePath;
  final String siteName;
  final String sitePlace;
  final String rating;
  final double width;
  final double height;
  final String ratingsize;
  final String Description;
  const VisitMorrocoCard1({
    super.key,
    required this.ImagePath,
    required this.siteName,
    required this.sitePlace,
    required this.rating,
    required this.width,
    required this.height,
    required this.ratingsize,
    required this.Description,
  });

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 0.5, color: gold),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: width / 2,
            height: height,
            child: Image.asset(
              alignment: Alignment.centerLeft,
              ImagePath,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width / 50,
                  vertical: ScreenSize.width / 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        siteName,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "SFDisplay",
                          fontSize: ScreenSize.width / 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.width / 40,
                      ),
                      Text(
                        Description,
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: "SFDisplay",
                          fontSize: ScreenSize.width / 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 20,
                            color: ajired,
                          ),
                          Text(
                            sitePlace,
                            style: TextStyle(
                              fontFamily: "SFDisplay",
                              color: ajired,
                              fontSize: ScreenSize.width / 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.width / 50,
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
                      SizedBox(
                        height: ScreenSize.width / 50,
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
            ),
          )
        ],
      ),
    );
  }
}
