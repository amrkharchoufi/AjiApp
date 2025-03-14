import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/service_name_widget.dart';
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
                ServiceNameWidget(name: "Visa"),
                SizedBox(
                  height: ScreenSize.height / 120,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: ScreenSize.height / 60),
                  child: Row(
                    children: [
                      Image(
                        image: Svg("assets/icons/${widget.country}_icon.svg"),
                        width: ScreenSize.width / 4.5,
                        height: ScreenSize.width / 4.5,
                      ),
                      SizedBox(
                        width: ScreenSize.width / 30,
                      ),
                      Text(
                        widget.country,
                        style: TextStyle(
                            fontFamily: "SFDisplay",
                            fontSize: ScreenSize.width / 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
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
                        height: ScreenSize.width / 4,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: gold,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenSize.width / 15,
                            vertical: ScreenSize.width / 40,
                          ),
                        ),
                        child: Text(
                          "Book your Flight",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: (ScreenSize.width / 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
