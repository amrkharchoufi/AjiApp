import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class Matchwidget extends StatelessWidget {
  final String ImagePath;
  final String MatchTitleaway;
  final String MatchTitlehome;
  final String MatchDate;
  final String Matchplace;
  final String Price;
  final double width;
  final double height;
  const Matchwidget({
    super.key,
    required this.ImagePath,
    required this.MatchTitleaway,
    required this.MatchTitlehome,
    required this.MatchDate,
    required this.Matchplace,
    required this.Price,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    SizeConfig().init(context);
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
                    children: [
                      Text(
                        MatchTitlehome,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: ScreenSize.width / 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                          'Vs',
                          style: TextStyle(
                            fontSize: SizeConfig.getBlockSizeHorizontal(5),
                            fontWeight: FontWeight.bold,
                            color: ajired,
                          ),
                        ),
                      Text(
                        MatchTitleaway,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                        
                          fontSize: ScreenSize.width / 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenSize.width / 50),
                  Text(
                    MatchDate,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenSize.width / 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: ScreenSize.width / 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                  ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ajired,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: Size(
                          SizeConfig.getBlockSizeHorizontal(35),
                            SizeConfig.getBlockSizeVertical(2.5)
                          ),
                        ),
                        child: Text(
                          "Learn More",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: (SizeConfig.getBlockSizeHorizontal(4)),
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

