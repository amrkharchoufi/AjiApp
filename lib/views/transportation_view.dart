import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/city_to_city_view.dart';
import 'package:ajiapp/views/concierge_view.dart';
import 'package:ajiapp/views/in_city_view.dart';
import 'package:ajiapp/views/rent_car_view.dart';
import 'package:ajiapp/views/trans_main_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class Transportationview extends StatefulWidget {
  const Transportationview({super.key});

  @override
  State<Transportationview> createState() => _TransportationviewState();
}

class _TransportationviewState extends State<Transportationview> {
  int index=0;

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
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        Image(image: Svg("assets/images/logowhite.svg")),
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
              // Rent a car section
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
                                child: Image(
                                  image: Svg("assets/icons/rent_car.svg"),
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
                                child: Image(
                                  image: Svg("assets/icons/concierge.svg"),
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
                                          : Color.fromARGB(255, 177, 113, 127),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Image(
                                  image: Svg("assets/icons/city_to_city.svg"),
                                ),
                              ),
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
                                          : Color.fromARGB(255, 177, 113, 127),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Image(
                                  image: Svg("assets/icons/in_city.svg"),
                                ),
                              ),
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
