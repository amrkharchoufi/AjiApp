import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/visit_morocco_all.dart';
import 'package:ajiapp/views/visit_morocco_home.dart';
import 'package:ajiapp/views/visit_morroco_city.dart';
import 'package:ajiapp/widgets/visit_morocco_card2.dart';
import 'package:ajiapp/widgets/visit_morroco_card1.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class VisitMorrocoView extends StatefulWidget {
  const VisitMorrocoView({super.key});

  @override
  State<VisitMorrocoView> createState() => _VisitMorrocoViewState();
}

class _VisitMorrocoViewState extends State<VisitMorrocoView> {
  final List<String> cities = [
    "All the Country",
    "Rabat",
    "Marrakech ",
    "Casanlanca",
    "Tangier",
    "Fes",
    "Essaouira",
  ];
  Widget Custom = VisitMoroccoHome();

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
                            "Visit Morocco",
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
                          onChanged: (value) => {
                            if (value == "All the Country")
                              {
                                setState(() {
                                  Custom = VisitMoroccoAll();
                                })
                              }
                            else
                              {
                                setState(() {
                                  Custom = VisitMoroccoCity(city: value!);
                                })
                              }
                          },
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.width / 20,
                      ),
                      Custom
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
