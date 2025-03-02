import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final bool imgicon;
  final IconData icon;
  final Image img;
  const ServiceWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      required this.imgicon,
      required this.icon,
      required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: gold, width: 0.7),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imgicon
              ? Icon(
                  icon,
                  color: ajired,
                  size: ScreenSize.width / 12,
                )
              : img,
          Text(
            text,
            style: TextStyle(
                color: ajired,
                fontWeight: FontWeight.bold,
                fontSize: ScreenSize.width / 30),
          )
        ],
      ),
    );
  }
}
