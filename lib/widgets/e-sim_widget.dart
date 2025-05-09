// ignore_for_file: deprecated_member_use

import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class E_simWidget extends StatelessWidget {
  final String? data;
  final String? durations;
  final String? price;
  const E_simWidget({super.key, this.data, this.durations, this.price});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.getBlockSizeVertical(2),
          horizontal: SizeConfig.getBlockSizeHorizontal(3)),
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.getBlockSizeHorizontal(2),),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(data!,
              style: TextStyle(
                fontSize: SizeConfig.getBlockSizeHorizontal(6),
                fontWeight: FontWeight.bold,
              )),
              Text(durations!,
              style: TextStyle(
                fontSize:SizeConfig.getBlockSizeHorizontal(4.5),
                fontWeight: FontWeight.w500,
                color: Colors.black,
              )),
              Text(price!,
              style: TextStyle(
                fontSize: SizeConfig.getBlockSizeHorizontal(4.5),
                fontWeight: FontWeight.w500,
                color: gold,
              )),
        ],
      ),
    );
  }
}