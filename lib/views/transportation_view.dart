import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/available_cars_widget.dart';
import 'package:ajiapp/widgets/search_bar_widget.dart';
import 'package:ajiapp/widgets/top_brands_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class TransportationView extends StatelessWidget {
  const TransportationView({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: ajired,
                size: ScreenSize.width / 13,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.account_circle_outlined,
                color: ajired,
                size: ScreenSize.width / 12,
              ),
            ),
          ],
        ),
        body: Container(
          width: ScreenSize.width,
          height: ScreenSize.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
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
                          Image(
                            image: Svg("assets/images/logowhite.svg"),
                          ),
                          SizedBox(
                            width: ScreenSize.width / 25,
                          ),
                          Text(
                            "Transportation",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenSize.width / 13.5,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: ScreenSize.width / 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: ScreenSize.height * 0.03),
                      SearchBarWidget(),
                      SizedBox(height: ScreenSize.height * 0.02),
                      TopBrandsWidget(),
                      SizedBox(height: ScreenSize.height * 0.02),
                      AvailableCarsWidget(),
                      SizedBox(height: ScreenSize.height * 0.02),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
