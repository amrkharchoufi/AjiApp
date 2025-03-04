import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class WithoutVisaView extends StatefulWidget {
  final String country;
  const WithoutVisaView({super.key, required this.country});

  @override
  State<WithoutVisaView> createState() => _WithoutVisaViewState();
}

class _WithoutVisaViewState extends State<WithoutVisaView> {
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
                            "Visa",
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
                Row(
                  children: [
                  Image(image: Svg("assets/icons/algeria_icon.svg"),),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(ScreenSize.height / 60),
                  child: Column(
                    children: [
                      Text(
                        "Get visa information before your next trip to Morroco",
                        style: TextStyle(
                            fontFamily: "SFDisplay",
                            fontSize: ScreenSize.width / 21,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Search your nationality to find out the documents you need for your visa application",
                        style: TextStyle(
                          fontFamily: "SFDisplay",
                          fontSize: ScreenSize.width / 25,
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.width / 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
