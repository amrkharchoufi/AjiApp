import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/car_item_widget.dart';
import 'package:flutter/material.dart';

class AvailableCarsWidget extends StatelessWidget {

  const AvailableCarsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final List<Map<String, dynamic>> cars = [
      {
        'brandLogo': 'assets/icon/bmw.svg',
        'carImage': 'assets/images/bmw.png',
        'modelName': 'Benz C-Class',
        'rating': 4.5,
        'transmission': 'Manual',
        'fuel': 'Diesel',
        'seats': '5 seats',
        'price': '600',
      },
      {
        'brandLogo': 'assets/icon/bmw.svg',
        'carImage': 'assets/images/bmw.png',
        'modelName': 'BMW 3 Series',
        'rating': 4.7,
        'transmission': 'Automatic',
        'fuel': 'Petrol',
        'seats': '5 seats',
        'price': '1200',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Available Cars'),
        SizedBox(height: ScreenSize.height * 0.01),
        Column(
          children: cars
              .map((car) => CarItem(
                    brandLogo: car['brandLogo'] as String,
                    carImage: car['carImage'] as String,
                    modelName: car['modelName'] as String,
                    rating: (car['rating'] as num).toDouble(),
                    transmission: car['transmission'] as String,
                    fuel: car['fuel'] as String,
                    seats: car['seats'] as String,
                    price: car['price'].toString(),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: ScreenSize.width * 0.05, fontWeight: FontWeight.bold),
    );
  }
}
