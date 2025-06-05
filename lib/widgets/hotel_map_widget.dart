import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HotelMapWidget extends StatelessWidget {
  final String hotel_name;
  final String Image_link;
  const HotelMapWidget({super.key, required this.hotel_name, required this.Image_link});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.getBlockSizeHorizontal(75),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.getBlockSizeHorizontal(5)),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            height: SizeConfig.getBlockSizeVertical(13),
            width: SizeConfig.getBlockSizeHorizontal(60),
            child: CachedNetworkImage(
              imageUrl: Image_link,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: SizeConfig.getBlockSizeHorizontal(50),
            child: Text(
              textAlign: TextAlign.center,
              hotel_name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.getBlockSizeHorizontal(5)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Learn more"),
              Row(
                spacing: SizeConfig.getBlockSizeHorizontal(1),
                children: [
                  Text(
                    "4.6",
                    style: TextStyle(
                        fontSize: ScreenSize.width / 27, color: Colors.black),
                  ),
                  SvgPicture.asset("assets/icons/star_icon.svg"),
                  Text(
                    "(512)",
                    style: TextStyle(
                        fontSize: ScreenSize.width / 30, color: Colors.black),
                  ),
                ],
              ),
              MaterialButton(
                onPressed: () {},
                color: ajired,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                minWidth: SizeConfig.getBlockSizeHorizontal(5),
                height: SizeConfig.getBlockSizeVertical(3),
                child: Text(
                  "Book now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.getBlockSizeHorizontal(3),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
