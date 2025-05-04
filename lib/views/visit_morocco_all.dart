import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/visit_morocco_card2.dart';
import 'package:flutter/material.dart';

class VisitMoroccoAll extends StatefulWidget {
  const VisitMoroccoAll({super.key});

  @override
  State<VisitMoroccoAll> createState() => _VisitMoroccoAllState();
}

class _VisitMoroccoAllState extends State<VisitMoroccoAll> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Most Popular",
              style: TextStyle(
                  
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
                  
                  fontSize: 19,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: ScreenSize.width / 40,
        ),
        VisitMoroccoCard2(
            designred: false,
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
            designred: false,
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
          designred: false,
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
            designred: false,
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
      ],
    );
  }
}
