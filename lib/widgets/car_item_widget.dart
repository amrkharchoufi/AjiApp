import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarItem extends StatelessWidget {
  final String brandLogo;
  final String carImage;
  final String modelName;
  final double rating;
  final String transmission;
  final String fuel;
  final String seats;
  final String price;
  final VoidCallback? onRent;

  const CarItem({
    super.key,
    required this.brandLogo,
    required this.carImage,
    required this.modelName,
    required this.rating,
    required this.transmission,
    required this.fuel,
    required this.seats,
    required this.price,
    this.onRent,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.012),
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      brandLogo.isNotEmpty
                          ? SvgPicture.asset(brandLogo, width: 50, height: 50)
                          : const Icon(Icons.car_rental, size: 50, color: Colors.grey),
                      const SizedBox(height: 8),
                      Text(
                        modelName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(5, (index) {
                          if (index < rating.floor()) {
                            return const Icon(Icons.star, color: Colors.amber, size: 18);
                          } else if (index == rating.floor() && rating % 1 >= 0.5) {
                            return const Icon(Icons.star_half, color: Colors.amber, size: 18);
                          } else {
                            return const Icon(Icons.star_border, color: Colors.amber, size: 18);
                          }
                        }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: carImage.isNotEmpty
                      ? Image.asset(carImage, width: size.width * 0.45, fit: BoxFit.cover)
                      : const Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _carFeature(transmission),
                _carFeature(fuel),
                _carFeature(seats),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$price MAD',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    const SizedBox(width: 4),
                    const Text("Day", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: onRent,
                  child: const Text('Rent Now', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _carFeature(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey[700], fontSize: 14, fontWeight: FontWeight.w500),
    );
  }
}
