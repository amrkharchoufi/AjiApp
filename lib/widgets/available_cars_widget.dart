import 'package:ajiapp/widgets/car_item_widget.dart';
import 'package:flutter/material.dart';


class AvailableCarsWidget extends StatelessWidget {
  final void Function(Map<String, dynamic> car)? onCarTap;

  const AvailableCarsWidget({super.key, this.onCarTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<Map<String, dynamic>> cars = [
      {
        'brandLogo': 'assets/icons/mercedes.svg',
        'carImage': 'assets/images/bmw.png',
        'modelName': 'Benz C-Class',
        'rating': 4.5,
        'transmission': 'Manual',
        'fuel': 'Diesel',
        'seats': '5 seats',
        'price': '600',
      },
      {
        'brandLogo': 'assets/icons/mercedes.svg',
        'carImage': 'assets/images/bmw.png',
        'modelName': 'A5 Sportback',
        'rating': 4.6,
        'transmission': 'Automatic',
        'fuel': 'Diesel',
        'seats': '5 seats',
        'price': '1750',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Available Cars',
              style: TextStyle(
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                  const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              onPressed: () {},
              child: const Text("View all"),
            ),
          ],
        ),

        SizedBox(height: size.height * 0.02),

        // ListView adaptatif avec shrinkWrap
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cars.length,
          itemBuilder: (context, index) {
            final car = cars[index];

            return GestureDetector(
              onTap: () {
                if (onCarTap != null) {
                  onCarTap!(car);
                }
              },
              child: CarItem(
                brandLogo: car['brandLogo'],
                carImage: car['carImage'],
                modelName: car['modelName'],
                rating: 4.6,
                transmission: car['transmission'],
                fuel: car['fuel'],
                seats: car['seats'],
                price: car['price'],
                onRent: () {
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
