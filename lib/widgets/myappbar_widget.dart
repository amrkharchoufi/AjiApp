import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/notification_view.dart';
import 'package:ajiapp/views/profile_view.dart';
import 'package:flutter/material.dart';

class MyappbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const MyappbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: ScreenSize.height / 12,
      iconTheme: IconThemeData(color: ajired),
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => NotificationView()),
          ),
          icon: Icon(Icons.notifications_outlined, size: ScreenSize.width / 12),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProfileView()),
          ),
          icon:
              Icon(Icons.account_circle_outlined, size: ScreenSize.width / 12),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenSize.height / 12);
}
