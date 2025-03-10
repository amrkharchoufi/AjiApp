import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopBrandsWidget extends StatelessWidget {

  final List<String> brands = [
    'assets/icons/bmw.svg',
    'assets/icons/hyundai.svg',
    'assets/icons/mercedes.svg',
    'assets/icons/peugeot.svg',
    'assets/icons/toyota.svg',
  ];

  TopBrandsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Top Brands'),
        SizedBox(height: ScreenSize.height * 0.01),
        SizedBox(
          height: ScreenSize.height * 0.12,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            separatorBuilder: (_, __) => SizedBox(width: ScreenSize.width * 0.04),
            itemBuilder: (context, index) {
              return Container(
                width: ScreenSize.width * 0.28,
                height: ScreenSize.width * 0.18,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(ScreenSize.width * 0.03),
                  child: SvgPicture.asset(
                    brands[index],
                    width: ScreenSize.width * 0.12,
                    height: ScreenSize.width * 0.12,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
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
