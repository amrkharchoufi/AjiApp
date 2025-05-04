import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ajiapp/settings/size.dart';

class ServiceNameWidget extends StatelessWidget {
  final String name;
  const ServiceNameWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 5,
          child: Opacity(
            opacity: 0.4,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 10,sigmaY: 1),
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                    Colors.black, BlendMode.srcIn),
                child: SvgPicture.asset(
                  "assets/images/custom_header.svg",
                  width: ScreenSize.width,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
        SvgPicture.asset(
          "assets/images/custom_header.svg",
          width: ScreenSize.width,
          fit: BoxFit.fitWidth,
        ),
        Center(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.getBlockSizeHorizontal(9.5),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
