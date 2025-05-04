import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';

class EsimView extends StatefulWidget {
  const EsimView({super.key});

  @override
  State<EsimView> createState() => _EsimViewState();
}

class _EsimViewState extends State<EsimView> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
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
                MyappbarWidget(
                  title: "E-Sim",
                ),
                SizedBox(
                  height: ScreenSize.height / 6,
                ),
                Container(
                  width: ScreenSize.width / 2,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(width: 1, color: gold),
                  ),
                  child: Center(
                    child: Text(
                      "This Service will \nbe available soon",
                      style: TextStyle(
                          color: ajired,
                          fontFamily: "SFDisplay",
                          fontSize: ScreenSize.width / 19),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
