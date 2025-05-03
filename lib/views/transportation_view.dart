import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:ajiapp/widgets/service_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Transportationview extends StatefulWidget {
  const Transportationview({super.key});

  @override
  State<Transportationview> createState() => _TransportationviewState();
}

class _TransportationviewState extends State<Transportationview> {
  int index = 0;

  List<Widget> pages = [

  ];

  bool isCarService = false;

  bool isCityToCity = false;

  bool isRentCar = false;

  bool isInCity = false;

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      appBar: MyappbarWidget(),
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
              ServiceNameWidget(name: "Transportation"),
              
            ],
          ),
        ),
      ),
    );
  }
}
