import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/available%20_soon_widget.dart';
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
                Available_SoonWidget()
              ],
            ),
          ),
        ));
  }
}
