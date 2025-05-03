import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServiceNameWidget extends StatelessWidget {
  final String name;
  const ServiceNameWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    SizeConfig.init(context);
    return Stack(
      children: [
        // Image.asset(
        //   "assets/images/shape.png",
        //   width: ScreenSize.width,
        //   fit: BoxFit.fitWidth,
        // ),
        SvgPicture.asset(
          "assets/images/custom_header.svg",
          width: ScreenSize.width,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          bottom: SizeConfig.getblockSizeVertical(5.5),
          left: SizeConfig.getblockSizeHorizontal(43),
          child: Text(
            name,
            style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.getblockSizeVertical(3.5),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
