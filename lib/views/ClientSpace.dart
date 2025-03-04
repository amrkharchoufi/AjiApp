import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/Service_view.dart';
import 'package:ajiapp/views/available_soon.dart';

import 'package:ajiapp/views/homepage_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class Clientspace extends StatefulWidget {
  const Clientspace({super.key});

  @override
  ClientspaceState createState() => ClientspaceState();
}

class ClientspaceState extends State<Clientspace> {
  
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    AvailableSoon(),
    ServiceView(),
    AvailableSoon(),
    AvailableSoon(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              width: ScreenSize.width / 15,
              height: ScreenSize.width / 15,
              child: Image(image:Svg('assets/icons/homeicon.svg')),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: ScreenSize.width / 15,
              height: ScreenSize.width / 15,
              child: Image(image: Svg("assets/icons/eventicon.svg")),
            ),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: ScreenSize.width / 15,
              height: ScreenSize.width / 15,
              child: Image(image: Svg("assets/icons/services.svg")),
            ),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: ScreenSize.width / 15,
              height: ScreenSize.width / 15,
              child: Image(image: Svg("assets/icons/search.svg")),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: ScreenSize.width / 15,
              height: ScreenSize.width / 15,
              child: Image(image: Svg("assets/icons/avatar.svg")),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
