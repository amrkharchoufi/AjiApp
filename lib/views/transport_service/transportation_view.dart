
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/available%20_soon_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';


class Transportationview extends StatefulWidget {
  const Transportationview({super.key});

  @override
  State<Transportationview> createState() => _TransportationviewState();
}

class _TransportationviewState extends State<Transportationview> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyappbarWidget(
                title: "Transportation",
              ),
              SizedBox(
                  height: ScreenSize.height / 6,
                ),
              Center(child: Available_SoonWidget())
            ],
          ),
        ),
      ),
    );
  }
}
