import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/services/common/notification_view.dart';
import 'package:ajiapp/services/profile/profile_view.dart';
import 'package:ajiapp/widgets/service_name_widget.dart';
import 'package:flutter/material.dart';

class MyappbarWidget extends StatelessWidget{
  final String title;
  const MyappbarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: ajired,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
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
        ),
        ServiceNameWidget(name: title)
      ],
    );
  }
}
