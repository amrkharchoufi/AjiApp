import 'package:ajiapp/services/followyourteam_service/model/stadium_model.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StadiumWidget extends StatelessWidget {
  final StadiumModel stadium;
  final double width;
  final double height;
  const StadiumWidget({
    super.key,
    required this.stadium,
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
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // Light shadow
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: width / 2.1,
            height: height,
            child: CachedNetworkImage(
              imageUrl: stadium.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width / 50,
                  vertical: ScreenSize.height / 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        stadium.name,
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
                        stadium.city,
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
                      MaterialButton(
                        onPressed: () {},
                        color: ajired,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minWidth: SizeConfig.getBlockSizeHorizontal(35),
                        height: SizeConfig.getBlockSizeVertical(3),
                        child: Text(
                          "Learn More",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.getBlockSizeHorizontal(3.5),
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
