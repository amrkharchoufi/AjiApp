import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/available%20_soon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AvailableSoon extends StatelessWidget {
  const AvailableSoon({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.width / 20,
                    vertical: ScreenSize.height / 30),
                width: double.infinity,
                height: ScreenSize.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover)),
                child: Column(children: [
                  SizedBox(
                    height: ScreenSize.height / 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset("assets/icons/aji_icon.svg"),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Hello,",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenSize.height / 4,
                  ),
                  Available_SoonWidget()
                ]))));
  }
}
