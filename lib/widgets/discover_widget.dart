import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class DiscoverCard extends StatelessWidget {
  final String ImagePath;
  final String siteName;
  final String sitePlace;
  final String Entry;
  final double width;
  final double height;
  const DiscoverCard({
    super.key,
    required this.ImagePath,
    required this.siteName,
    required this.sitePlace,
    required this.Entry,
    required this.width,
    required this.height,
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
            width: width / 2.1,
            height: height,
            child: Image.asset(
              ImagePath,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize.width / 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        siteName,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          
                          fontSize: ScreenSize.width / 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: ScreenSize.width / 50),
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
                              
                              color: ajired,
                              fontSize: ScreenSize.width / 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenSize.width / 50),
                      Text(
                        Entry,
                        style: TextStyle(
                          
                          fontSize: ScreenSize.width / 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: ScreenSize.width / 50),
                    ],
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
                      ),
                    ),
                    child: Text(
                      "Learn More",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: (ScreenSize.width / 22),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}