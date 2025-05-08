// ignore_for_file: deprecated_member_use

import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/services/common/Service_view.dart';
import 'package:ajiapp/services/common/available_soon.dart';

import 'package:ajiapp/services/common/homepage_view.dart';
import 'package:ajiapp/services/profile/view/profile_view.dart';
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
    SizeConfig().init(context);

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: ajired,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.getBlockSizeHorizontal(3)),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal,fontSize: SizeConfig.getBlockSizeHorizontal(3)),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/hotelicon.svg",color: Colors.brown,width: SizeConfig.getBlockSizeHorizontal(7),height: SizeConfig.getBlockSizeHorizontal(7),),
            activeIcon: SvgPicture.asset("assets/icons/hotelicon.svg",color: ajired,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/events_icon.svg",color: Colors.brown,width: SizeConfig.getBlockSizeHorizontal(7),height: SizeConfig.getBlockSizeHorizontal(7),),
            activeIcon: SvgPicture.asset("assets/icons/events_icon.svg",color: ajired,),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/service_icon.svg",color: Colors.brown,width: SizeConfig.getBlockSizeHorizontal(7),height: SizeConfig.getBlockSizeHorizontal(7),),
            activeIcon: SvgPicture.asset("assets/icons/service_icon.svg",color: ajired,),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/search_icon.svg",color: Colors.brown,width: SizeConfig.getBlockSizeHorizontal(7),height: SizeConfig.getBlockSizeHorizontal(7),),
            activeIcon: SvgPicture.asset("assets/icons/search_icon.svg",color: ajired,),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/profile_icon.svg",color: Colors.brown,width: SizeConfig.getBlockSizeHorizontal(7),height: SizeConfig.getBlockSizeHorizontal(7),),
            activeIcon: SvgPicture.asset("assets/icons/profile_icon.svg",color: ajired,),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
