import 'package:ajiapp/settings/size.dart';
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
  });

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenSize.width * 0.04),
      ),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.01),
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.width * 0.04),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(brandLogo, width: ScreenSize.width * 0.14, height: ScreenSize.width * 0.12),
                    const SizedBox(height: 6),
                    Text(
                      modelName,
                      style: TextStyle(fontSize: ScreenSize.width * 0.045, fontWeight: FontWeight.bold),
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
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(carImage, width: ScreenSize.width * 0.49, fit: BoxFit.cover),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _carFeature(transmission),
                _carFeature(fuel),
                _carFeature(seats),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '$price MAD',
                      style: TextStyle(fontSize: ScreenSize.width * 0.05, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    const SizedBox(width: 4),
                    const Text("Day", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                SizedBox(
                  width: ScreenSize.width * 0.3,
                  height: ScreenSize.height * 0.04,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    child: const Text('Rent Now', style: TextStyle(color: Colors.white)),
                  ),
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
      style: TextStyle(color: Colors.grey[700], fontSize: ScreenSize.width * 0.034, fontWeight: FontWeight.w500),
    );
  }
}
