import 'package:ajiapp/backend/authentification_functions.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/services/common/notification_view.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NotificationView(),
                ),
              );
            },
            icon: Icon(
              Icons.notifications_outlined,
              color: ajired,
              size: ScreenSize.width / 13,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.account_circle,
              color: ajired,
              size: ScreenSize.width / 12,
            ),
          ),
          IconButton(
            onPressed: () {
              signout(context);
            },
            icon: Icon(
              Icons.logout_outlined,
              color: ajired,
              size: ScreenSize.width / 12,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenSize.width / 20),
        width: ScreenSize.width,
        height: ScreenSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: ScreenSize.width / 20,
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: ScreenSize.width / 6,
                        backgroundImage:
                            AssetImage("assets/images/profile.png"),
                        backgroundColor: ajired,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.all(ScreenSize.width / 40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            Icons.edit,
                            color: ajired,
                            size: ScreenSize.width / 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Username",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenSize.width / 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenSize.width / 20,
              ),
              Row(
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                        
                        fontSize: ScreenSize.width / 13.5,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenSize.width / 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "City: ",
                            style: TextStyle(
                                color: ajired,
                                fontSize: ScreenSize.width / 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Porto-Novo, Benin ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenSize.width / 30,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.width / 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "E-mail: ",
                            style: TextStyle(
                                color: ajired,
                                fontSize: ScreenSize.width / 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "test@ajiapp.com",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenSize.width / 30,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenSize.width / 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Phone Number: ",
                            style: TextStyle(
                                color: ajired,
                                fontSize: ScreenSize.width / 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "0123456789 ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenSize.width / 30,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.width / 20,
                      ),
                      Row(
                        children: [
                        Text(
                            "Language: ",
                            style: TextStyle(
                                color: ajired,
                                fontSize: ScreenSize.width / 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "English",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenSize.width / 30,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: ScreenSize.width / 20,
              ),
              Row(
                children: [
                  Text(
                    "Settings",
                    style: TextStyle(
                        fontSize: ScreenSize.width / 13.5,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenSize.width / 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lock,
                            color: ajired,
                            size: ScreenSize.width / 18,
                          ),
                          Text(
                            "Change password",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenSize.width / 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.width / 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.credit_card,
                            color: ajired,
                            size: ScreenSize.width / 18,
                          ),
                          Text(
                            "Payment methods",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenSize.width / 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.width / 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.language,
                            color: ajired,
                            size: ScreenSize.width / 18,
                          ),
                          Text(
                            "Language",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenSize.width / 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenSize.width / 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            color: ajired,
                            size: ScreenSize.width / 18,
                          ),
                          Text(
                            "Change phone number ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenSize.width / 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.width / 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: ajired,
                            size: ScreenSize.width / 18,
                          ),
                          Text(
                            "Change email",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenSize.width / 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.width / 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.fmd_good_sharp,
                            color: ajired,
                            size: ScreenSize.width / 18,
                          ),
                          Text(
                            "Country ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenSize.width / 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
