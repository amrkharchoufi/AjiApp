// lib/widgets/visit_morocco_card2.dart
import 'package:ajiapp/services/tourisme_service/model/tourism_model.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VisitMoroccoCard2 extends StatelessWidget {
  final Tour tour;
  final bool designred;
  final double? width;
  final double? height;

  const VisitMoroccoCard2({
    super.key,
    required this.tour,
    this.designred = false,
    this.width,
    this.height,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: cardWidth,
            height: cardHeight / 2.5,
            child: _isNetworkImage(tour.imageUrl)
                ? CachedNetworkImage(
                    imageUrl: tour.imageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
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
                    tour.imageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
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
                  tour.name,
                  softWrap: true,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: ScreenSize.width / 20,
                      fontWeight: FontWeight.bold,
                      color: designred ? Colors.white : Colors.black),
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
                        Icon(Icons.hourglass_empty,
                            size: 23,
                            color: designred ? Colors.white : Colors.black),
                        Text(
                          tour.duration,
                          style: TextStyle(
                              fontSize: ScreenSize.width / 25,
                              fontWeight: FontWeight.bold,
                              color: designred ? Colors.white : Colors.black),
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
                        Icon(Icons.location_on_outlined,
                            size: 23,
                            color: designred ? Colors.white : Colors.black),
                        Text(
                          tour.startingCity,
                          style: TextStyle(
                            color: designred ? Colors.white : Colors.black,
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
                          tour.rating,
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
                          "(${tour.ratingCount})",
                          style: TextStyle(
                              fontSize: ScreenSize.width / 30,
                              color: designred ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenSize.width / 40,
                ),
                Text(
                  tour.description,
                  softWrap: true,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: ScreenSize.width / 35,
                      fontWeight: FontWeight.bold,
                      color: designred ? Colors.white : Colors.black),
                ),
                SizedBox(
                  height: ScreenSize.width / 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tour.price,
                      style: TextStyle(
                          color: !designred
                              ? Color.fromARGB(255, 28, 73, 29)
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenSize.width / 15),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle navigation to tour details
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !designred ? ajired : Colors.white,
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
          )
        ],
      ),
    );
  }
}
