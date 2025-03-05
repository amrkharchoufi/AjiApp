import 'package:flutter/material.dart';
import 'section_header.dart';
import 'restaurant_card.dart';

class RestaurantSection extends StatelessWidget {
  const RestaurantSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 16.0), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: "Restaurants",),
          
          SizedBox(
            height: 310,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                RestaurantCard(
                  title: "Dar Naji",
                  rating: "4.2",
                  reviews: "4.4k",
                  address: "Av. Jazirat Al Arabe, Rabat",
                  imagePath: "assets/images/dar-zaki.png",
                ),
                RestaurantCard(
                  title: "Zaz",
                  rating: "4.4",
                  reviews: "1.9k",
                  address: "Hay Ait Souka, Rabat",
                  imagePath: "assets/images/dar-zaki.png",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
