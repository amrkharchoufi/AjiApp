import 'package:ajiapp/services/accomodation_service/model/hotel_model.dart';
import 'package:ajiapp/services/accomodation_service/view/view_more_hotel_view.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HotelWidget extends StatelessWidget {
  // Touristhotel object is required
  final Hotel_model hotel;

  // Optional parameters for visual customization
  final double? width;
  final double? height;
  final bool designred;

  const HotelWidget({
    super.key,
    required this.hotel,
    this.width,
    this.height,
    this.designred = false,
  });

  // Helper method to check if the image is a network image
  bool _isNetworkImage(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    final cardWidth = width ?? ScreenSize.width / 1.06;
    final cardHeight = height ?? ScreenSize.height / 3;

    return Container(
      width: cardWidth,
      height: cardHeight,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: cardWidth / 2,
            height: cardHeight,
            child: _isNetworkImage(hotel.imageUrl)
                ? CachedNetworkImage(
                    imageUrl: hotel.imageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  )
                : Image.asset(
                    hotel.imageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
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
                        hotel.title,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: ScreenSize.width / 20,
                            fontWeight: FontWeight.bold,
                            color: designred ? Colors.white : Colors.black),
                      ),
                      SizedBox(
                        height: ScreenSize.width / 40,
                      ),
                      Text(
                        hotel.description,
                        softWrap: true,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: ScreenSize.width / 30,
                            color: designred ? Colors.white : Colors.black),
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
                            color: designred ? Colors.white : ajired,
                          ),
                          Text(
                            hotel.city,
                            style: TextStyle(
                              color: designred ? Colors.white : Colors.black,
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
                            // hotel.rating,
                            "4.4",
                            style: TextStyle(
                                fontSize: ScreenSize.width / 25,
                                fontWeight: FontWeight.bold,
                                color: designred ? Colors.white : Colors.black),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(
                            // "(${hotel.ratingCount})",
                            "500",
                            style: TextStyle(
                                fontSize: ScreenSize.width / 30,
                                color: designred ? Colors.white : Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.width / 50,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Get.to(ViewMoreHotelView(spot: hotel));
                        },
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
