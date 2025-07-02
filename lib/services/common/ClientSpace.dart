// ignore_for_file: deprecated_member_use

import 'package:ajiapp/services/coming-up_service/view/ComingUp_view.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/services/common/Service_view.dart';
import 'package:ajiapp/services/common/available_soon.dart';
import 'package:ajiapp/services/home/view/homepage_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Clientspace extends StatefulWidget {
  const Clientspace({super.key});

  @override
  ClientspaceState createState() => ClientspaceState();
}

class ClientspaceState extends State<Clientspace> {
  int _selectedIndex = 0;

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return ComingUp();
      case 2:
        return const ServiceView();
      case 3:
        return const AvailableSoon();
      default:
        return const HomePage();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final Map<String, Widget> _svgCache = {};

  Widget _getSvg(String path, Color color) {
    final key = '$path-$color';
    if (!_svgCache.containsKey(key)) {
      _svgCache[key] = SvgPicture.asset(
        path,
        color: color,
        width: SizeConfig.getBlockSizeHorizontal(6),
        height: SizeConfig.getBlockSizeHorizontal(6),
      );
    }
    return _svgCache[key]!;
  }

  Widget _getSvgactive(String path, Color color) {
    final key = '$path-$color';
    if (!_svgCache.containsKey(key)) {
      _svgCache[key] = SvgPicture.asset(
        path,
        color: color,
      );
    }
    return _svgCache[key]!;
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    SizeConfig().init(context);

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: List.generate(
          5,
          (index) => _selectedIndex == index ? _getPage(index) : Container(),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: beige,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: ajired,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.getBlockSizeHorizontal(3)),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: SizeConfig.getBlockSizeHorizontal(3)),
          items: [
            BottomNavigationBarItem(
              icon: _getSvg(
                "assets/icons/hotelicon.svg",
                Colors.brown,
              ),
              activeIcon: _getSvgactive(
                "assets/icons/hotelicon.svg",
                ajired,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _getSvg("assets/icons/events_icon.svg", Colors.brown),
              activeIcon: _getSvgactive(
                "assets/icons/events_icon.svg",
                ajired,
              ),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: _getSvg(
                "assets/icons/service_icon.svg",
                Colors.brown,
              ),
              activeIcon: _getSvgactive(
                "assets/icons/service_icon.svg",
                ajired,
              ),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: _getSvg(
                "assets/icons/search_icon.svg",
                Colors.brown,
              ),
              activeIcon: _getSvgactive(
                "assets/icons/search_icon.svg",
                ajired,
              ),
              label: 'Search',
            ),
          ],
        ),
      ),
    );
  }
}
