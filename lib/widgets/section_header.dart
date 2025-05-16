import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? actionWidget;
  const SectionHeader({super.key, required this.title, this.actionWidget});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.getBlockSizeHorizontal(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: SizeConfig.getBlockSizeHorizontal(6.8),
                  fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: () {
              if (actionWidget == null) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => actionWidget!,
                ),
              );
            },
            child: Text("View all",
                style: TextStyle(
                  fontSize: SizeConfig.getBlockSizeHorizontal(4),
                )),
          ),
        ],
      ),
    );
  }
}
