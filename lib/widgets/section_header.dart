import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style:  TextStyle(fontSize:SizeConfig.getBlockSizeHorizontal(6.8), fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () {},
          child:  Text("View all", style: TextStyle(color: gold,fontSize: SizeConfig.getBlockSizeHorizontal(4))),
        ),
      ],
    );
  }
}
