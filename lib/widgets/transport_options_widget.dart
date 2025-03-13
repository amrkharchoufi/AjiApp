import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransportOptionsWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const TransportOptionsWidget({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  static const List<Map<String, String>> options = [
    {'label': 'Rent a Car', 'icon': 'assets/icon/directions_car.svg'},
    {'label': 'Car Service', 'icon': 'assets/icon/concierge1.svg'},
    {'label': 'City to City', 'icon': 'assets/icon/city.svg'},
    {'label': 'In City', 'icon': 'assets/icon/directions_bus.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(options.length, (index) {

        final bool isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () => onSelect(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isSelected ? size.width * 0.18 : size.width * 0.15,
                height: isSelected ? size.width * 0.18 : size.width * 0.15,
                decoration: BoxDecoration(

                  color: selectedIndex==4?const Color(0xff97051D): isSelected

                      ? const Color(0xff97051D)
                      : const Color(0xffbb6270),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    options[index]['icon']!,
                    width: isSelected ? size.width * 0.09 : size.width * 0.08,
                    height: isSelected ? size.width * 0.09 : size.width * 0.08,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    placeholderBuilder: (context) => 
                        const CircularProgressIndicator(),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: size.width * 0.22,
                child: Text(
                  options[index]['label']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.black : Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}