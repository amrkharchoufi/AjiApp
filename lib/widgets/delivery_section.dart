import 'package:ajiapp/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'delivery_card.dart';

class DeliverySection extends StatelessWidget {
  const DeliverySection({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> deliveryOptions = [
      {
        "title": "McDelivery",
        "subtitle": "Arriving in 30 mins",
        "price": "Free",
        "image": "assets/images/bg.svg",
      },
      {
        "title": "Glovo",
        "subtitle": "Fast delivery",
        "price": "Paid",
        "image": "assets/images/glovo.svg",
      },
    ];

    return Padding(
  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 16.0), // Réduire le `top`
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SectionHeader(title: "Delivery and pick up"),
      SizedBox(
        height: 190,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: deliveryOptions.map((option) {
            return DeliveryCard(
              title: option["title"]!,
              subtitle: option["subtitle"]!,
              price: option["price"]!,
              imagePath: option["image"]!,
            );
          }).toList(),
        ),
      ),
    ],
  ),
);

  }
}
