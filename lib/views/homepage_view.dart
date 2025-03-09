import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/ComingUp_view.dart';
import 'package:ajiapp/views/Discover_view.dart';
import 'package:ajiapp/views/Service_view.dart';
import 'package:ajiapp/views/accomodation_view.dart';
import 'package:ajiapp/views/available_soon.dart';
import 'package:ajiapp/views/e-sim_view.dart';
import 'package:ajiapp/views/food_view.dart.dart';
import 'package:ajiapp/views/notification_view.dart';
import 'package:ajiapp/views/profile_view.dart';
import 'package:ajiapp/views/visa_view.dart';
import 'package:ajiapp/widgets/matches_widget.dart';
import 'package:ajiapp/widgets/morrcandoor_widget.dart';
import 'package:ajiapp/widgets/service_widget.dart';
import 'package:ajiapp/widgets/sitecard_widget.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.width / 20,
              vertical: ScreenSize.height / 30),
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image(
                        image: Svg("assets/images/logoaji.svg"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Hello,",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NotificationView(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.notifications_outlined,
                          color: ajired,
                          size: ScreenSize.width / 12,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileView(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.account_circle_outlined,
                          color: ajired,
                          size: ScreenSize.width / 12,
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              FadeInRight(
                duration: Duration(milliseconds: 1000),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Featured",
                      style: TextStyle(
                          fontFamily: "SFDisplay",
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "View all",
                      style: TextStyle(
                        fontFamily: "SFDisplay",
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FadeInUp(
                  duration: Duration(milliseconds: 1200),
                  child: Row(
                    children: [
                      FeatureCard(
                        title: "Get your E-sim",
                        subtitle: "Stay connected with inwi e-sim",
                        backgroundImage: AssetImage('assets/images/sim.jpg'),
                        description: 'Learn More',
                      ),
                      SizedBox(
                        width: ScreenSize.width / 20,
                      ),
                      FeatureCard(
                        title: "Morroco vs Comoros",
                        subtitle: "Dec,21,2025 at 18:00",
                        backgroundImage:
                            AssetImage('assets/images/matchday.jpg'),
                        description: 'Learn More',
                      ),
                      SizedBox(
                        width: ScreenSize.width / 20,
                      ),
                      FeatureCard(
                        title: "Your Guide to Morroco",
                        subtitle: "Aji app is your Companion in Morocco",
                        backgroundImage: AssetImage('assets/images/guide.jpg'),
                        description: 'Learn More',
                      ),
                      SizedBox(
                        width: ScreenSize.width / 20,
                      ),
                      FeatureCard(
                        title: "Hassan II Mosque",
                        subtitle: "Visit the Largest mosque in Morroco",
                        backgroundImage: AssetImage('assets/images/mosque.jpg'),
                        description: 'Book a Tour',
                      ),
                      SizedBox(
                        width: ScreenSize.width / 20,
                      ),
                      FeatureCard(
                        title: "Visit Dar Naji",
                        subtitle: "Get an unmatched taset of Morroco",
                        backgroundImage:
                            AssetImage('assets/images/f-image.jpg'),
                        description: 'Book a Tour',
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeInRight(
                duration: Duration(milliseconds: 1400),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Services",
                      style: TextStyle(
                          fontFamily: "SFDisplay",
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ServiceView(),
                          ),
                        );
                      },
                      child: Text(
                        "View all",
                        style: TextStyle(
                          fontFamily: "SFDisplay",
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1600),
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: ScreenSize.width / 25,
                  runSpacing: ScreenSize.width / 25,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EsimView(),
                          ),
                        );
                      },
                      child: ServiceWidget(
                          width: ScreenSize.width / 3.7,
                          height: ScreenSize.width / 3.7,
                          text: "e-sim",
                          imgicon: false,
                          icon: Icons.call_outlined,
                          img: Image(
                            image: Svg("assets/icons/Phone.svg"),
                            color: ajired,
                            width: ScreenSize.width / 14,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VisaView(),
                          ),
                        );
                      },
                      child: ServiceWidget(
                          width: ScreenSize.width / 3.7,
                          height: ScreenSize.width / 3.7,
                          text: "Visa",
                          imgicon: false,
                          icon: Icons.call_outlined,
                          img: Image(
                            image: Svg("assets/icons/Visa_icon.svg"),
                            color: ajired,
                            width: ScreenSize.width / 12,
                          )),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AvailableSoon(),
                            ),
                          );
                        },
                        child: ServiceWidget(
                          width: ScreenSize.width / 3.7,
                          height: ScreenSize.width / 3.7,
                          text: "Tickets",
                          imgicon: false,
                          icon: Icons.call_outlined,
                          img: Image(
                            image: Svg("assets/icons/Ticket_icon.svg"),
                            color: ajired,
                            width: ScreenSize.width / 12,
                          ),
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AvailableSoon(),
                          ),
                        );
                      },
                      child: ServiceWidget(
                          width: ScreenSize.width / 3.7,
                          height: ScreenSize.width / 3.7,
                          text: "Flights",
                          imgicon: false,
                          icon: Icons.call_outlined,
                          img: Image(
                            image: Svg("assets/icons/flight_icon.svg"),
                            color: ajired,
                            width: ScreenSize.width / 12,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AccomodationView(),
                          ),
                        );
                      },
                      child: ServiceWidget(
                          width: ScreenSize.width / 3.7,
                          height: ScreenSize.width / 3.7,
                          text: "Accommodation",
                          imgicon: false,
                          icon: FontAwesomeIcons.house,
                          img: Image(
                            image: Svg("assets/icons/Home.svg"),
                            color: ajired,
                            width: ScreenSize.width / 12,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AvailableSoon(),
                          ),
                        );
                      },
                      child: ServiceWidget(
                          width: ScreenSize.width / 3.7,
                          height: ScreenSize.width / 3.7,
                          text: "Transportation",
                          imgicon: false,
                          icon: Icons.call_outlined,
                          img: Image(
                            image: Svg("assets/icons/car_icon.svg"),
                            color: ajired,
                            width: ScreenSize.width / 12,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Discover(),
                          ),
                        );
                      },
                      child: ServiceWidget(
                          width: ScreenSize.width / 3.7,
                          height: ScreenSize.width / 3.7,
                          text: "Discover",
                          imgicon: false,
                          icon: Icons.call_outlined,
                          img: Image(
                            image: Svg("assets/icons/location.svg"),
                            color: ajired,
                            width: ScreenSize.width / 12,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FoodHomePage(),
                          ),
                        );
                      },
                      child: ServiceWidget(
                          width: ScreenSize.width / 3.7,
                          height: ScreenSize.width / 3.7,
                          text: "Food",
                          imgicon: false,
                          icon: Icons.call_outlined,
                          img: Image(
                            image: Svg("assets/icons/food.svg"),
                            color: ajired,
                            width: ScreenSize.width / 10,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AvailableSoon(),
                          ),
                        );
                      },
                      child: ServiceWidget(
                          width: ScreenSize.width / 3.7,
                          height: ScreenSize.width / 3.7,
                          text: "Important\nContacts",
                          imgicon: false,
                          icon: Icons.call_outlined,
                          img: Image(
                            image: Svg("assets/icons/alert.svg"),
                            color: ajired,
                            width: ScreenSize.width / 12,
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeInRight(
                duration: Duration(milliseconds: 1800),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Coming up",
                      style: TextStyle(
                          fontFamily: "SFDisplay",
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ComingUp(),
                          ),
                        );
                      },
                      child: Text(
                        "View all",
                        style: TextStyle(
                          fontFamily: "SFDisplay",
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FadeInUp(
                  duration: Duration(milliseconds: 2000),
                  child: Row(
                    children: [
                      Matchwidget(
                          width: ScreenSize.width / 1.2,
                          height: ScreenSize.height / 4,
                          ImagePath: "assets/images/match.jpg",
                          MatchTitle: "Morocco vs Zambia",
                          MatchDate: "16 December at 18:00",
                          Matchplace: "Sport Complexe Prince",
                          Price: "600"),
                      SizedBox(
                        width: ScreenSize.width / 20,
                      ),
                      Matchwidget(
                          width: ScreenSize.width / 1.2,
                          height: ScreenSize.height / 4,
                          ImagePath: "assets/images/match2.jpg",
                          MatchTitle: "Tunisia vs South Africa",
                          MatchDate: "16 December at 18:00",
                          Matchplace: "Sport Complexe Prince",
                          Price: "600")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeInRight(
                duration: Duration(milliseconds: 2200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Discover",
                      style: TextStyle(
                          fontFamily: "SFDisplay",
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Discover(),
                          ),
                        );
                      },
                      child: Text(
                        "View all",
                        style: TextStyle(
                          fontFamily: "SFDisplay",
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FadeInUp(
                  duration: Duration(milliseconds: 2400),
                  child: Row(
                    children: [
                      SiteCard(
                          title: "Mausoleum of Mohammed V",
                          backgroundImage:
                              AssetImage("assets/images/city1.png")),
                      SizedBox(
                        width: ScreenSize.width / 30,
                      ),
                      SiteCard(
                          title: "Hassan Tower",
                          backgroundImage:
                              AssetImage("assets/images/city2.png")),
                      SizedBox(
                        width: ScreenSize.width / 30,
                      ),
                      SiteCard(
                          title: "Hassan II Mosque",
                          backgroundImage:
                              AssetImage("assets/images/mosque.png")),
                      SizedBox(
                        width: ScreenSize.width / 30,
                      ),
                      SiteCard(
                          title: "Hercules Caves",
                          backgroundImage:
                              AssetImage("assets/images/hercules.png"))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
