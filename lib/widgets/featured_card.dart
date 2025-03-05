import 'package:flutter/material.dart';

class FoodFeaturedCard extends StatelessWidget {
  final String title, rating, reviews, address, imagePath;
  final bool fullWidth;

  const FoodFeaturedCard({
    super.key,
    required this.title,
    required this.rating,
    required this.reviews,
    required this.address,
    required this.imagePath,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? 280 : 250,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28)),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 16),
                Expanded(child: Text("$rating ($reviews)", style: const TextStyle(color: Colors.white, fontSize: 15))),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red, size: 16),
                Expanded(child: Text(address, style: const TextStyle(color: Colors.white, fontSize: 15))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
