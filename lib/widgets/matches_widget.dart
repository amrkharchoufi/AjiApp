import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class Matchwidget extends StatelessWidget {
  final String ImagePath;
  final String MatchTitle;
  final String MatchDate;
  final String Matchplace;
  final String Price;
  final double width;
  final double height;
  const Matchwidget({
    super.key,
    required this.ImagePath,
    required this.MatchTitle,
    required this.MatchDate,
    required this.Matchplace,
    required this.Price,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MatchTitle,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                        
                          fontSize: ScreenSize.width / 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: ScreenSize.width / 50),
                      Text(
                        MatchDate,
                        style: TextStyle(
                          color: ajired,
                        
                          fontSize: ScreenSize.width / 35,
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
                          ),
                          Text(
                            Matchplace,
                            style: TextStyle(
                              
                              fontSize: ScreenSize.width / 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenSize.width / 50),
                      Text(
                        "FROM $Price MAD",
                        style: TextStyle(
                        
                          fontSize: ScreenSize.width / 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: ScreenSize.width / 50),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(gold),
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(
                          vertical: ScreenSize.width / 70,
                          horizontal: ScreenSize.width / 20,
                        ),
                      ),
                    ),
                    child: Text(
                      "Book now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenSize.width / 22,
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
