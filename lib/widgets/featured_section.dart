import 'package:flutter/material.dart';
import 'section_header.dart';
import 'featured_card.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: "Featured"),
          SizedBox(
            height: 261,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                FeaturedCard(
                  title: "Dar Zaki",
                  rating: "4.5",
                  reviews: "494",
                  address: "23 Rue Moulay Brahim, Rabat",
                  imagePath: "assets/images/dar-zaki.png",
                  fullWidth: true,
                ),
                FeaturedCard(
                  title: "Sufra",
                  rating: "4.5",
                  reviews: "19",
                  address: "Av. Mohamed VI, Rabat",
                  imagePath: "assets/images/dar-zaki2.png",
                  fullWidth: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
