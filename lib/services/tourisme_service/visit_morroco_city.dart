import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/visit_morocco_card2.dart';
import 'package:ajiapp/widgets/visit_morroco_card1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VisitMoroccoCity extends StatelessWidget {
  final String city;
  const VisitMoroccoCity({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        width: ScreenSize.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                   ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(17)),
                  child: Image.asset(
                    'assets/images/rabat.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SingleChildScrollView(
                      child: Column(
                        children: [
                            SizedBox(
                  height: ScreenSize.height / 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.width / 20,
                      vertical: ScreenSize.width / 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Column(
                    spacing: ScreenSize.width / 30,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("City",
                            style: TextStyle(
                            fontSize: ScreenSize.width / 25,
                              
                              color: gold
                            ),
                          ),
                          Text("Interest",
                            style: TextStyle(
                            fontSize: ScreenSize.width / 25,
                              
                              color: gold
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("$city",
                            style: TextStyle(
                            fontSize: ScreenSize.width / 18,
                              fontWeight: FontWeight.w500,
                            
                            ),
                          ),
                          Text("History",
                            style: TextStyle(
                            fontSize: ScreenSize.width / 18,
                              fontWeight: FontWeight.w500,
                              
                            ),
                          ),
                        ],
                      )
                    ],
                  )),

                          VisitMorrocoCard1(
                            ImagePath: "assets/images/oudaya.png",
                            siteName: "Kasbah des Oudayas",
                            sitePlace: "Rabat",
                            rating: "4,6",
                            ratingsize: "445",
                            Description:
                                "An iconic fortified neighborhood overlooking the Atlantic Ocean. It’s famous for its picturesque, blue-and-white painted alleyways, beautiful Andalusian gardens, and historic architecture dating back to the 12th century.",
                            width: ScreenSize.width / 1.06,
                            height: ScreenSize.height / 2.3,
                            designred: true,
                          ),
                          SizedBox(
                            height: ScreenSize.width / 30,
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
                            height: ScreenSize.height / 2.3,
                            designred: true,
                          ),
                          SizedBox(
                            height: ScreenSize.width / 30,
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
                            height: ScreenSize.height / 2.3,
                            designred: true,
                          ),
                          SizedBox(
                            height: ScreenSize.width / 30,
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
                            height: ScreenSize.height / 2.3,
                            designred: true,
                          ),
                        ],
                      ),
                    ),
                  
              ],
            ),
          
          
          ],
        ),
      ),
    );
  }
}

