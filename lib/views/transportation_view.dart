import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/city_to_city_view.dart';
import 'package:ajiapp/views/concierge_view.dart';
import 'package:ajiapp/views/in_city_view.dart';
import 'package:ajiapp/views/rent_car_view.dart';
import 'package:ajiapp/views/trans_main_page_view.dart';
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
    TransMainPageView(),
    RentCarView(),
    CarServiceView(),
    CityToCityScreen(),
    InCityScreen()
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
              Padding(
                padding: EdgeInsets.all(ScreenSize.height / 60),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isRentCar = true;
                              isCarService = false;
                              isCityToCity = false;
                              isInCity = false;
                              index = 1;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: (isCarService == false &&
                                        isCityToCity == false &&
                                        isInCity == false &&
                                        isRentCar == false)
                                    ? ScreenSize.width / 6
                                    : isRentCar
                                        ? ScreenSize.width / 5
                                        : ScreenSize.width / 6,
                                height: (isCarService == false &&
                                        isCityToCity == false &&
                                        isInCity == false &&
                                        isRentCar == false)
                                    ? ScreenSize.width / 6
                                    : isRentCar
                                        ? ScreenSize.width / 5
                                        : ScreenSize.width / 6,
                                decoration: BoxDecoration(
                                  color: (isCarService == false &&
                                          isCityToCity == false &&
                                          isInCity == false &&
                                          isRentCar == false)
                                      ? ajired
                                      : isRentCar
                                          ? ajired
                                          : Color.fromARGB(255, 177, 113, 127),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(ScreenSize.width /
                                      30), // Add padding for spacing
                                  child: SvgPicture.asset(
                                    "assets/icons/rent_car.svg",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Text(
                                "Rent a car",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 25,
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isCarService = true;
                              isCityToCity = false;
                              isInCity = false;
                              isRentCar = false;
                              index = 2;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: (isCarService == false &&
                                        isCityToCity == false &&
                                        isInCity == false &&
                                        isRentCar == false)
                                    ? ScreenSize.width / 6
                                    : isCarService
                                        ? ScreenSize.width / 5
                                        : ScreenSize.width / 6,
                                height: (isCarService == false &&
                                        isCityToCity == false &&
                                        isInCity == false &&
                                        isRentCar == false)
                                    ? ScreenSize.width / 6
                                    : isCarService
                                        ? ScreenSize.width / 5
                                        : ScreenSize.width / 6,
                                decoration: BoxDecoration(
                                  color: (isCarService == false &&
                                          isCityToCity == false &&
                                          isInCity == false &&
                                          isRentCar == false)
                                      ? ajired
                                      : isCarService
                                          ? ajired
                                          : Color.fromARGB(255, 177, 113, 127),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(ScreenSize.width / 30),
                                  child: SvgPicture.asset(
                                      "assets/icons/concierge_icon.svg"),
                                ),
                              ),
                              Text(
                                "Car Service",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 25,
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isCityToCity = true;
                              isCarService = false;
                              isInCity = false;
                              isRentCar = false;
                              index = 3;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: (isCarService == false &&
                                          isCityToCity == false &&
                                          isInCity == false &&
                                          isRentCar == false)
                                      ? ScreenSize.width / 6
                                      : isCityToCity
                                          ? ScreenSize.width / 5
                                          : ScreenSize.width / 6,
                                  height: (isCarService == false &&
                                          isCityToCity == false &&
                                          isInCity == false &&
                                          isRentCar == false)
                                      ? ScreenSize.width / 6
                                      : isCityToCity
                                          ? ScreenSize.width / 5
                                          : ScreenSize.width / 6,
                                  decoration: BoxDecoration(
                                    color: (isCarService == false &&
                                            isCityToCity == false &&
                                            isInCity == false &&
                                            isRentCar == false)
                                        ? ajired
                                        : isCityToCity
                                            ? ajired
                                            : Color.fromARGB(
                                                255, 177, 113, 127),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(ScreenSize.width / 30),
                                    child: SvgPicture.asset(
                                        "assets/icons/city_to_city.svg"),
                                  )),
                              Text(
                                "City to City",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 25,
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isInCity = true;
                              isCarService = false;
                              isCityToCity = false;
                              isRentCar = false;
                              index = 4;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: (isCarService == false &&
                                          isCityToCity == false &&
                                          isInCity == false &&
                                          isRentCar == false)
                                      ? ScreenSize.width / 6
                                      : isInCity
                                          ? ScreenSize.width / 5
                                          : ScreenSize.width / 6,
                                  height: (isCarService == false &&
                                          isCityToCity == false &&
                                          isInCity == false &&
                                          isRentCar == false)
                                      ? ScreenSize.width / 6
                                      : isInCity
                                          ? ScreenSize.width / 5
                                          : ScreenSize.width / 6,
                                  decoration: BoxDecoration(
                                    color: (isCarService == false &&
                                            isCityToCity == false &&
                                            isInCity == false &&
                                            isRentCar == false)
                                        ? ajired
                                        : isInCity
                                            ? ajired
                                            : Color.fromARGB(
                                                255, 177, 113, 127),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(ScreenSize.width / 30),
                                    child: SvgPicture.asset(
                                        "assets/icons/in_city.svg"),
                                  )),
                              Text(
                                "In City",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 25,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    pages[index],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
