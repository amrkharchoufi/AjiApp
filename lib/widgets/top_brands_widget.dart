import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopBrandsWidget extends StatelessWidget {
  final void Function(String brandName)? onBrandTap;

  const TopBrandsWidget({super.key, this.onBrandTap});

  static const brands = [
    {'logo': 'assets/icons/bmw.svg', 'name': 'BMW'},
    {'logo': 'assets/icons/hyundai.svg', 'name': 'Hyundai'},
    {'logo': 'assets/icons/mercedes.svg', 'name': 'Mercedes'},
    {'logo': 'assets/icons/peugeot.svg', 'name': 'Peugeot'},
    {'logo': 'assets/icons/toyota.svg', 'name': 'Other'},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Brands',
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
        SizedBox(height: size.height * 0.015),
        SizedBox(
          height: size.height * 0.13,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            separatorBuilder: (_, __) => SizedBox(width: size.width * 0.04),
            itemBuilder: (context, index) {
              final brand = brands[index];
              return GestureDetector(
                onTap: () {
                  if (onBrandTap != null) {
                    onBrandTap!(brand['name']!);
                  }
                },
                child: Container(
                  width: size.width * 0.28,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha((0.2 * 255).toInt()),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(size.width * 0.03),
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
    return SvgPicture.asset(
      logoPath,
      fit: BoxFit.contain,
      placeholderBuilder: (_) =>
          const Center(child: CircularProgressIndicator()),
    );
  }
}
