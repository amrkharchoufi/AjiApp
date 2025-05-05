import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceWidget extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final bool golden;
  final double? customzie;
  final String img;
  const ServiceWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      required this.img,
      required this.golden, this.customzie});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: golden ? gold : Colors.white,
          border: Border.all(color: golden ? white : gold, width: 1),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            img,
            width: customzie,
            // ignore: deprecated_member_use
            color: golden ? Colors.white : null,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: golden ? white : ajired,
                fontWeight: FontWeight.bold,
                fontSize: ScreenSize.width / 33),
          )
        ],
      ),
    );
  }
}
