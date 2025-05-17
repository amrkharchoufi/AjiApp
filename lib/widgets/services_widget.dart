import 'package:ajiapp/routing.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/utils/svg_cache.dart';
import 'package:ajiapp/widgets/service_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesWidget extends StatelessWidget {
  final double? rownb;
  const ServicesWidget({super.key, this.rownb});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // Define services only once to avoid recreating ServiceWidget instances
    List<Widget> services = [
      _buildServiceTile(
        "Visit Morocco",
        "assets/icons/visit_icon.svg",
        () => Get.toNamed(Routes.VISIT_MOROCCO),
        customSize: SizeConfig.getBlockSizeHorizontal(6),
      ),
      _buildServiceTile(
        "Visa",
        "assets/icons/Visa_icon.svg",
        () => Get.toNamed(Routes.VISA),
      ),
      _buildServiceTile(
        "Your team",
        "assets/icons/ball_icon.svg",
        () => Get.toNamed(Routes.FOLLOWYOURTEAM),
      ),
      _buildServiceTile(
        "E-sim",
        "assets/icons/Phone.svg",
        () => Get.toNamed(Routes.ESIM),
      ),
      _buildServiceTile(
        "Hotels",
        "assets/icons/hotelicon.svg",
        () => Get.toNamed(Routes.ACCOMMODATION),
      ),
      _buildServiceTile(
        "Contacts",
        "assets/icons/contact_icon.svg",
        () => Get.toNamed(Routes.CONTACTS),
      ),
      _buildServiceTile(
        "Food",
        "assets/icons/food.svg",
        () => Get.toNamed(Routes.FOOD),
        customSize: SizeConfig.getBlockSizeHorizontal(9.5),
      ),
      _buildServiceTile(
        "Tickets",
        "assets/icons/Ticket_icon.svg",
        () => Get.toNamed(Routes.TICKETS),
        customSize: SizeConfig.getBlockSizeHorizontal(9),
      ),
      _buildServiceTile(
        "Transportation",
        "assets/icons/car_icon.svg",
        () => Get.toNamed(Routes.TRANSPORTATION),
        customSize: SizeConfig.getBlockSizeHorizontal(9),
      ),
    ];

    // Calculate how many services to show based on rownb parameter
    final int servicesToShow =
        rownb != null ? (rownb! * 3).toInt() : services.length;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.width / 25),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: ScreenSize.width / 25,
        runSpacing: ScreenSize.width / 25,
        children: services.take(servicesToShow).toList(),
      ),
    );
  }

  // Build an individual service tile with proper performance optimizations
  Widget _buildServiceTile(String text, String iconPath, VoidCallback onTap,
      {double? customSize}) {
    return GestureDetector(
      onTap: onTap,
      child: ServiceWidget(
        key: ValueKey('service-$text'),
        golden: false,
        width: ScreenSize.width / 3.7,
        height: ScreenSize.width / 3.7,
        text: text,
        customzie: customSize,
        img: iconPath,
      ),
    );
  }
}
