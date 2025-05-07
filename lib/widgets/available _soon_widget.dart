import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Available_SoonWidget extends StatelessWidget {
  const Available_SoonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Column(
      children: [
        SvgPicture.asset("assets/images/ticktock.svg",
            width: ScreenSize.width / 3),
        SizedBox(
          height: ScreenSize.height /30,
        ),
        Text(
          textAlign: TextAlign.center,
            "This Service will be\navailable soon",
              style: TextStyle(
              color: ajired,
              fontWeight: FontWeight.bold,        
              fontSize: ScreenSize.width / 19),
                      ),
      ],
    );
  }
}