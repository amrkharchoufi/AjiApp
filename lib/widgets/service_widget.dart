import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/utils/svg_cache.dart';
import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final bool golden;
  final double? customzie;
  final String img;

  const ServiceWidget({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    required this.img,
    required this.golden,
    this.customzie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: golden ? gold : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Use cached SVG for better performance
          SvgCache.getAsset(
            img,
            width: customzie,
            color: golden ? Colors.white : null,
          ),
          const SizedBox(height: 5),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: golden ? white : ajired,
              fontWeight: FontWeight.bold,
              fontSize: ScreenSize.width / 33,
              // Add letter spacing for better readability
              letterSpacing: 0.5,
            ),
          )
        ],
      ),
    );
  }
}
