import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/utils/svg_cache.dart';

class ServiceNameWidget extends StatelessWidget {
  final String name;
  const ServiceNameWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background shadow - optimized with reduced blur operations
        Positioned(
          top: 3,
          child: Opacity(
            opacity: 0.2,
            child: ColorFiltered(
              colorFilter:
                  const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              child: SvgCache.getAsset(
                "assets/images/custom_header.svg",
                width: ScreenSize.width,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        // Foreground SVG - cached for better performance
        SvgCache.getAsset(
          "assets/images/custom_header.svg",
          width: ScreenSize.width,
          fit: BoxFit.fitWidth,
        ),
        // Title text
        Center(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.getBlockSizeHorizontal(9),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
