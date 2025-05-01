import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransMainPageView extends StatefulWidget {
  const TransMainPageView({super.key});

  @override
  State<TransMainPageView> createState() => _TransMainPageViewState();
}

class _TransMainPageViewState extends State<TransMainPageView> {
  static const rentCarBrands = [
    {'logo': 'assets/icons/bmw.svg', 'name': 'BMW'},
    {'logo': 'assets/icons/mercedes.svg', 'name': 'Mercedes'},
    {'logo': 'assets/icons/peugeot.svg', 'name': 'Peugeot'},
  ];

  static const carServiceBrands = [
    {'logo': 'assets/icons/hertz1.svg', 'name': 'Hertz'},
    {'logo': 'assets/icons/sixt.svg', 'name': 'Sixt'},
    {'logo': 'assets/icons/europca.svg', 'name': 'Europcar'},
  ];

  static const cityToCityBrands = [
    {'logo': 'assets/icons/oncf.svg', 'name': 'ONCF'},
    {'logo': 'assets/icons/bus.svg', 'name': 'Bus'},
    {'logo': 'assets/icons/boraq.svg', 'name': 'Al Baraq'},
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCategorySection(context, 'Rent a car', rentCarBrands),
        const SizedBox(height: 8),

        // Car service section
        _buildCategorySection(context, 'Car service', carServiceBrands),
        const SizedBox(height: 8),

        _buildCategorySection(context, 'City to city', cityToCityBrands),
        const SizedBox(height: 8),
      ],
    );
  }
}

Widget _buildCategorySection(
    BuildContext context, String title, List<Map<String, String>> brands) {
  final size = MediaQuery.of(context).size;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 8),
              ),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
            ),
            onPressed: () {},
            child: const Text(
              "View all",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: size.height * 0.01),
      SizedBox(
        height: size.height * 0.11,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: brands.length,
          separatorBuilder: (_, __) => SizedBox(width: size.width * 0.04),
          itemBuilder: (context, index) {
            final brand = brands[index];
            return GestureDetector(
              onTap: () {},
              child: Container(
                width: size.width * 0.28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey
                          .withAlpha((0.15 * 255).toInt()), // 15% opacity
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: _buildBrandLogo(brand['logo']!),
              ),
            );
          },
        ),
      ),
    ],
  );
}

Widget _buildBrandLogo(String logoPath) {
  return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SvgPicture.asset(
        logoPath,
      ));
}
