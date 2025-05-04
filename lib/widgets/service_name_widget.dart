import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServiceNameWidget extends StatelessWidget {
  final String name;
  const ServiceNameWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
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
        )
      ],
    );
  }
}
