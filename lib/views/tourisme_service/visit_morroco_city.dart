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
                Positioned(
                  top: ScreenSize.width / 2,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                            child: Row(
                          children: [
                            SizedBox(
                              width: ScreenSize.width / 13,
                              height: ScreenSize.width / 13,
                              child: SvgPicture.asset(
                                  "assets/icons/activity_icon.svg"),
                            ),
                            SizedBox(width: ScreenSize.width / 20),
                            Text(
                              "Activities",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 25),
                            )
                          ],
                        )),
                        Tab(
                            child: Row(children: [
                          SizedBox(
                            width: ScreenSize.width / 13,
                            height: ScreenSize.width / 13,
                            child:
                                SvgPicture.asset("assets/icons/Tours_icon.svg"),
                          ),
                          SizedBox(width: ScreenSize.width / 20),
                          Text(
                            "Tour",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenSize.width / 25),
                          )
                        ]))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: TabBarView(
                children: [
                  Activities(),
                  Tour(),
                ],
              ),
            ),
            SizedBox(
              height: ScreenSize.width / 10,
            )
          ],
        ),
      ),
    );
  }
}

class Activities extends StatefulWidget {
  const Activities({super.key});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
    );
  }
}

class Tour extends StatefulWidget {
  const Tour({super.key});

  @override
  State<Tour> createState() => _TourState();
}

class _TourState extends State<Tour> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          VisitMoroccoCard2(
              designred: true,
              ImagePath: "assets/images/merzoga.png",
              siteName: "Tour from Marrakech to Fes and Merzouga Desert",
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
            height: ScreenSize.width / 30,
          ),
          VisitMoroccoCard2(
              designred: true,
              ImagePath: "assets/images/ouarzazat.png",
              siteName: "Tour from Ouarzazate to Zagora desert",
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
            height: ScreenSize.width / 30,
          ),
          VisitMoroccoCard2(
            designred: true,
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
            height: ScreenSize.width / 30,
          ),
          VisitMoroccoCard2(
              designred: true,
              ImagePath: "assets/images/Tangier.png",
              siteName: "Tour from Ouarzazate to Zagora desert",
              sitePlace: "Tangier",
              rating: "4,5",
              ratingsize: "3.4k",
              duree: "6 days",
              price: "3900 MAD",
              Description:
                  "Journey from Tangier to Marrakech, exploring Chefchaouen’s blue streets, Fes’ rich history, the Sahara’s golden dunes, and Berber villages before crossing the Atlas Mountains to reach vibrant Marrakech.",
              width: ScreenSize.width / 1.06,
              height: ScreenSize.height / 2.3),
          SizedBox(
            height: ScreenSize.width / 30,
          ),
        ],
      ),
    );
  }
}
