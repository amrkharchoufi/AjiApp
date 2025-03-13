import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
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
                            // Navigator.of(context).push(
                            //     MaterialPageRoute(
                            //       builder: (context) => WithoutVisaView(country: value!,),
                            //     ),
                            //   )

                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => WithVisa(country: value!,),
                            //   ),
                            // )
                          },
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.width / 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Most Visits",
                            style: TextStyle(
                                fontFamily: "SFDisplay",
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => ServiceView(),
                              //   ),
                              // );
                            },
                            child: Text(
                              "View all",
                              style: TextStyle(
                                fontFamily: "SFDisplay",
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.width / 40,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            VisitMorrocoCard1(
                                ImagePath: "assets/images/oudaya.png",
                                siteName: "Kasbah des Oudayas",
                                sitePlace: "Rabat",
                                rating: "4,6",
                                ratingsize: "445",
                                Description:
                                    "An iconic fortified neighborhood overlooking the Atlantic Ocean. It’s famous for its picturesque, blue-and-white painted alleyways, beautiful Andalusian gardens, and historic architecture dating back to the 12th century.",
                                width: ScreenSize.width / 1.06,
                                height: ScreenSize.height / 2.3),
                            SizedBox(
                              width: ScreenSize.width / 30,
                            ),
                            VisitMorrocoCard1(
                                ImagePath: "assets/images/hassantower.jpeg",
                                siteName: "Hassan Tower",
                                sitePlace: "Rabat",
                                rating: "4,6",
                                ratingsize: "9.9k",
                                Description:
                                    "A symbolic 12th-century minaret of an unfinished mosque, standing as Rabat’s most recognizable monument. Surrounded by ancient stone pillars, it showcases impressive Almohad-era architecture.",
                                width: ScreenSize.width / 1.06,
                                height: ScreenSize.height / 2.3),
                            SizedBox(
                              width: ScreenSize.width / 30,
                            ),
                            VisitMorrocoCard1(
                                ImagePath: "assets/images/mmohammedv.png",
                                siteName: "Mausoleum of Mohammed V",
                                sitePlace: "Rabat",
                                rating: "4,6",
                                ratingsize: "3.4k",
                                Description:
                                    "An elegant tomb of King Mohammed V and King Hassan II. Renowned for its detailed Moroccan architecture, intricate mosaics, marble craftsmanship, and ceremonial Royal Guards at its entrances.",
                                width: ScreenSize.width / 1.06,
                                height: ScreenSize.height / 2.3),
                            SizedBox(
                              width: ScreenSize.width / 30,
                            ),
                            VisitMorrocoCard1(
                                ImagePath: "assets/images/chellah.png",
                                siteName: "Chellah Necropolis",
                                sitePlace: "Rabat",
                                rating: "4,6",
                                ratingsize: "3.4k",
                                Description:
                                    "An enchanting historical site combining ancient Roman ruins and medieval Islamic structures. Known for its tranquil atmosphere, lush gardens, and nesting storks atop ancient walls.",
                                width: ScreenSize.width / 1.06,
                                height: ScreenSize.height / 2.3),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.width / 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Multi City Tour",
                            style: TextStyle(
                                fontFamily: "SFDisplay",
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => ServiceView(),
                              //   ),
                              // );
                            },
                            child: Text(
                              "View all",
                              style: TextStyle(
                                fontFamily: "SFDisplay",
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.width / 40,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            VisitMoroccoCard2(
                                ImagePath: "assets/images/merzoga.png",
                                siteName:
                                    "Tour from Marrakech to Fes and Merzouga Desert",
                                sitePlace: "Marrakech",
                                rating: "4,6",
                                ratingsize: "3.4k",
                                duree: "4 days",
                                price: "2000 MAD",
                                Description:
                                    "A 4-day tour from Marrakech to Fes offers stunning mountain views, ancient kasbahs, camel trekking in golden dunes, breathtaking gorges, lush valleys, starry desert nights, and scenic forest landscapes.",
                                width: ScreenSize.width / 1.06,
                                height: ScreenSize.height / 2.3),
                            SizedBox(
                              width: ScreenSize.width / 30,
                            ),
                            VisitMoroccoCard2(
                                ImagePath: "assets/images/ouarzazat.png",
                                siteName:
                                    "Tour from Ouarzazate to Zagora desert",
                                sitePlace: "Ouarzazate",
                                rating: "4,6",
                                ratingsize: "3.4k",
                                duree: "3 days",
                                price: "2500 MAD",
                                Description:
                                    "Embark on a thrilling tour from Ouarzazate to Merzouga Desert and Zagora, crossing the Draa Valley, exploring ancient kasbahs, and enjoying camel treks, desert camps, and breathtaking Sahara sunsets.",
                                width: ScreenSize.width / 1.06,
                                height: ScreenSize.height / 2.3),
                            SizedBox(
                              width: ScreenSize.width / 30,
                            ),
                            VisitMoroccoCard2(
                              ImagePath: "assets/images/chefchaouen.png",
                              siteName: "Tour from Casablanca to Chefchaouen",
                              sitePlace: "Casablanca",
                              rating: "4,6",
                              ratingsize: "3.4k",
                              duree: "3 days",
                              Description:
                                  "Tour from Casablanca to Chefchaouen, exploring Rabat’s landmarks, wandering through the blue-washed streets of Chefchaouen, and enjoying breathtaking Rif Mountain views in a peaceful setting.",
                              width: ScreenSize.width / 1.06,
                              height: ScreenSize.height / 2.3,
                              price: '1500 MAD',
                            ),
                            SizedBox(
                              width: ScreenSize.width / 30,
                            ),
                            VisitMoroccoCard2(
                                ImagePath: "assets/images/Tangier.png",
                                siteName:
                                    "Tour from Ouarzazate to Zagora desert",
                                sitePlace: "Tangier",
                                rating: "4,5",
                                ratingsize: "3.4k",
                                duree: "6 days",
                                price: "3900 MAD",
                                Description:
                                    "Journey from Tangier to Marrakech, exploring Chefchaouen’s blue streets, Fes’ rich history, the Sahara’s golden dunes, and Berber villages before crossing the Atlas Mountains to reach vibrant Marrakech.",
                                width: ScreenSize.width / 1.06,
                                height: ScreenSize.height / 2.3),
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
