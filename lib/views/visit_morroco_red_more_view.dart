import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class VisitMorrocoRedMoreView extends StatefulWidget {
  const VisitMorrocoRedMoreView({super.key});

  @override
  State<VisitMorrocoRedMoreView> createState() =>
      _VisitMorrocoRedMoreViewState();
}

class _VisitMorrocoRedMoreViewState extends State<VisitMorrocoRedMoreView> {
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
                            "Visit Morocco",
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
                SizedBox(
                  height: ScreenSize.height / 120,
                ),
                Container(
                  width: ScreenSize.width / 1.1,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17)),
                  child: Column(
                    children: [
                      SizedBox(
                          height: ScreenSize.width,
                          width: ScreenSize.width,
                          child: Image.asset(
                            "assets/images/hassantower.jpeg",
                            fit: BoxFit.fitWidth,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
