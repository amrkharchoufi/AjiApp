import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/common/Service_view.dart';
import 'package:ajiapp/views/common/available_soon.dart';

import 'package:ajiapp/views/common/homepage_view.dart';
import 'package:ajiapp/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    ProfileView(),
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
            icon: SvgPicture.asset("assets/icons/home_icon1.svg"),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/events_icon.svg"),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/service_icon.svg"),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/search_icon.svg"),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/profile_icon.svg"),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
