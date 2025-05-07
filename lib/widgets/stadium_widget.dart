import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class StadiumWidget extends StatelessWidget {
  final String ImagePath;
  final String MatchTitleaway;
  final String Matchplace;
  final double width;
  final double height;
  const StadiumWidget({
    super.key,
    required this.ImagePath,
    required this.MatchTitleaway,
    required this.Matchplace,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenSize.width / 45,
        vertical: ScreenSize.height / 100,
      ),
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
              padding: EdgeInsets.symmetric(horizontal: ScreenSize.width / 50,vertical: ScreenSize.height / 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        MatchTitleaway,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: ScreenSize.width / 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          ),
                    ],
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

