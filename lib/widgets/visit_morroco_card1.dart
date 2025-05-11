// lib/widgets/visit_morroco_card1.dart
import 'package:ajiapp/services/tourisme_service/model/tourism_model.dart';
import 'package:ajiapp/services/tourisme_service/view/visit_morroco_read_more_view.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VisitMorrocoCard1 extends StatelessWidget {
  // TouristSpot object is required
  final TouristSpot spot;

  // Optional parameters for visual customization
  final double? width;
  final double? height;
  final bool designred;

  const VisitMorrocoCard1({
    super.key,
    required this.spot,
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
    final cardHeight = height ?? ScreenSize.height / 2.3;

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
            child: _isNetworkImage(spot.imageUrl)
                ? CachedNetworkImage(
                    imageUrl: spot.imageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
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
                    spot.imageUrl,
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
                        spot.name,
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
                        spot.description,
                        softWrap: true,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: ScreenSize.width / 35,
                            fontWeight: FontWeight.bold,
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
                            spot.city,
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
                            spot.rating,
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
                            "(${spot.ratingCount})",
                            style: TextStyle(
                                fontSize: ScreenSize.width / 30,
                                color: designred ? Colors.white : Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.width / 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VisitMorrocoRedMoreView(
                                spot: spot,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: designred ? Colors.white : ajired,
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
            ),
          )
        ],
      ),
    );
  }
}
