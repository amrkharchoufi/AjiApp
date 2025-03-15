import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/morrcandoor_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:ajiapp/widgets/service_name_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccomodationView extends StatefulWidget {
  const AccomodationView({super.key});

  @override
  State<AccomodationView> createState() => _AccomodationViewState();
}

class _AccomodationViewState extends State<AccomodationView> {
  final List<String> cities = [
    "Rabat",
    "Sale",
    "Casablanca",
    "Marrakech",
  ];

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
              children: [
                ServiceNameWidget(name: "Accomodation"),
                SizedBox(
                  height: ScreenSize.height / 120,
                ),
                Padding(
                  padding: EdgeInsets.all(ScreenSize.height / 60),
                  child: Column(
                    children: [
                      SizedBox(
                        width: ScreenSize.width / 1.2,
                        child: DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSearchBox:
                                true, // Enables search in the dropdown
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.black54),
                                hintText: "Search for a city",
                                border: InputBorder
                                    .none, // Removes the default border
                              ),
                            ),
                            fit: FlexFit.loose,
                          ),
                          items: cities,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.search,
                                  color: Colors.black54), // Search icon
                              hintText: "Search for a city",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: ScreenSize.width / 10,
                                  vertical: ScreenSize.width / 30),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenSize.width / 10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          dropdownButtonProps: DropdownButtonProps(
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.black54),
                          ),
                          onChanged: (value) => {},
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.width / 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: ScreenSize.width / 6,
                                height: ScreenSize.width / 6,
                                decoration: BoxDecoration(
                                  color: ajired,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/hotel_icon.svg",
                                    width: ScreenSize.width / 10,
                                    height: ScreenSize.width / 10,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Text(
                                "Hotels",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 25,
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: ScreenSize.width / 6,
                                height: ScreenSize.width / 6,
                                decoration: BoxDecoration(
                                  color: ajired,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  // Ensures the icon stays centered
                                  child: SvgPicture.asset(
                                    "assets/icons/bed_icon.svg",
                                    width: ScreenSize.width /
                                        12, // Adjust for better visibility
                                    height: ScreenSize.width / 12,
                                    fit: BoxFit
                                        .contain, // Ensures it scales properly inside the container
                                  ),
                                ),
                              ),
                              Text(
                                "Airbnb",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 25,
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: ScreenSize.width / 6,
                                height: ScreenSize.width / 6,
                                decoration: BoxDecoration(
                                  color: ajired,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  // Ensures the icon stays centered
                                  child: SvgPicture.asset(
                                    "assets/icons/Home_icon.svg",
                                    width: ScreenSize.width /
                                        12, // Adjust for better visibility
                                    height: ScreenSize.width / 12,
                                    fit: BoxFit
                                        .contain, // Ensures it scales properly inside the container
                                  ),
                                ),
                              ),
                              Text(
                                "Stay here",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 25,
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: ScreenSize.width / 6,
                                height: ScreenSize.width / 6,
                                decoration: BoxDecoration(
                                  color: ajired,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  // Ensures the icon stays centered
                                  child: SvgPicture.asset(
                                    "assets/icons/more_icon.svg",
                                    width: ScreenSize.width /
                                        12, // Adjust for better visibility
                                    height: ScreenSize.width / 12,
                                    fit: BoxFit
                                        .contain, // Ensures it scales properly inside the container
                                  ),
                                ),
                              ),
                              Text(
                                "More",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 25,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.width / 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Featured",
                            style: TextStyle(
                                fontFamily: "SFDisplay",
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "View all",
                            style: TextStyle(
                              fontFamily: "SFDisplay",
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            FeatureCard(
                                title: "STAY HERE",
                                subtitle: "Book premier appartment in the city",
                                backgroundImage:
                                    AssetImage("assets/images/hotel1.jpg"),
                                description: "Book Now"),
                            SizedBox(width: 10),
                            FeatureCard(
                                title: "Bracelo",
                                subtitle:
                                    "an Hotel where comfort is a priotrity",
                                backgroundImage:
                                    AssetImage("assets/images/hotel2.jpg"),
                                description: "Book Now")
                          ],
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
