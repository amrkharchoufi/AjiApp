import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServiceNameWidget extends StatelessWidget {
  final String name;
  const ServiceNameWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Stack(
      children: [
        Image.asset(
          "assets/images/shape.png",
          width: ScreenSize.width,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          left: ScreenSize.width / 20,
          top: ScreenSize.height / 20,
          child: Row(
            children: [
              SvgPicture.asset("assets/images/logowhite.svg"),
              SizedBox(
                width: ScreenSize.width / 25,
              ),
              Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSize.width / 13.5,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }
}
