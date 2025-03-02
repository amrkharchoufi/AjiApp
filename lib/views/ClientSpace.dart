import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/available_soon.dart';
import 'package:ajiapp/views/homepage_view.dart';
import 'package:flutter/material.dart';

class Clientspace extends StatefulWidget {
  @override
  _ClientspaceState createState() => _ClientspaceState();
}

class _ClientspaceState extends State<Clientspace> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    AvailableSoon(),
    AvailableSoon(),
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
              child: Image.asset('assets/images/homeicon.png'),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: ScreenSize.width / 15,
              height: ScreenSize.width / 15,
              child: Image.asset('assets/images/ticketicon.png'),
            ),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: ScreenSize.width / 15,
              height: ScreenSize.width / 15,
              child: Image.asset('assets/images/services.png'),
            ),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: ScreenSize.width / 15,
              height: ScreenSize.width / 15,
              child: Image.asset('assets/images/Search.png'),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: ScreenSize.width / 15,
              height: ScreenSize.width / 15,
              child: Image.asset('assets/images/avatar.png'),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
