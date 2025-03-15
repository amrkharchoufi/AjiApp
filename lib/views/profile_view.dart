import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
              Row(
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                        color: green,
                        fontSize: ScreenSize.width / 13.5,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenSize.width / 20,
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: ScreenSize.width / 7.5,
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
                    "John Doe",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenSize.width / 20,
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
                            Icons.fmd_good_sharp,
                            color: ajired,
                            size: ScreenSize.width / 18,
                          ),
                          Text(
                            "Porto-Novo, Benin ",
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
                            Icons.alternate_email,
                            color: ajired,
                            size: ScreenSize.width / 18,
                          ),
                          Text(
                            "test@ajiapp.com",
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
                            "0123456789 ",
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
                            "English",
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
              SizedBox(
                height: ScreenSize.width / 20,
              ),
              Row(
                children: [
                  Text(
                    "Bookings",
                    style: TextStyle(
                        color: green,
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
                    children: [
                      Container(
                        width: ScreenSize.width / 2.5,
                        height: ScreenSize.height / 15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/flight_icon.svg"),
                            SizedBox(
                              width: ScreenSize.width / 20,
                            ),
                            Text(
                              "My Flights",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.width / 20,
                      ),
                      Container(
                        width: ScreenSize.width / 2.5,
                        height: ScreenSize.height / 15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/Phone.svg"),
                            SizedBox(
                              width: ScreenSize.width / 20,
                            ),
                            Text(
                              "My e-sim",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: ScreenSize.width / 2.5,
                        height: ScreenSize.height / 15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/Ticket_icon.svg"),
                            SizedBox(
                              width: ScreenSize.width / 20,
                            ),
                            Text(
                              "My Tickets",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.width / 20,
                      ),
                      Container(
                        width: ScreenSize.width / 2.5,
                        height: ScreenSize.height / 15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/car.svg"),
                            SizedBox(
                              width: ScreenSize.width / 20,
                            ),
                            Text(
                              "My travels",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenSize.width / 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
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
                        color: green,
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
