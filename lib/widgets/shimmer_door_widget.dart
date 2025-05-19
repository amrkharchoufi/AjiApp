import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/morrcandoor_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDoorCard extends StatelessWidget {
  const ShimmerDoorCard({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: SizeConfig.getBlockSizeHorizontal(35),
      height: SizeConfig.getBlockSizeVertical(27),
      child: Stack(
        children: [
          ClipPath(
            clipper: DoorContentClipper(),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
