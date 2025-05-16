import 'package:ajiapp/services/home/controller/home_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/services/common/ComingUp_view.dart';
import 'package:ajiapp/services/common/Discover_view.dart';
import 'package:ajiapp/services/common/Service_view.dart';
import 'package:ajiapp/services/common/notification_view.dart';
import 'package:ajiapp/widgets/matches_widget.dart';
import 'package:ajiapp/widgets/morrcandoor_widget.dart';
import 'package:ajiapp/widgets/section_header.dart';

import 'package:ajiapp/widgets/services_widget.dart';
import 'package:ajiapp/widgets/sitecard_widget.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenSize.init(context);
      SizeConfig().init(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: ScreenSize.height / 30),
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width / 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/aji_icon.svg",
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
                            controller.checklogin(context);
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
              ),
              SizedBox(
                height: 30,
              ),
              FadeInRight(
                duration: Duration(milliseconds: 1000),
                child: SectionHeader(title: "Featured"),
              ),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: Row(
                    spacing: ScreenSize.width / 20,
                    children: [
                      SizedBox(
                        width: ScreenSize.width / 80,
                      ),
                      FeatureCard(
                        title: "Follow your team!",
                        subtitle: "Find where your team plays next",
                        backgroundImage:
                            AssetImage('assets/images/follow_featured.jpg'),
                        description: 'Learn More',
                      ),
                      FeatureCard(
                        title: "Get your E-sim",
                        subtitle: "Stay connected with inwi e-sim",
                        backgroundImage: AssetImage('assets/images/sim.jpg'),
                        description: 'Learn More',
                      ),
                      FeatureCard(
                        title: "Morroco vs Comoros",
                        subtitle: "Dec,21,2025 at 18:00",
                        backgroundImage:
                            AssetImage('assets/images/matchday.jpg'),
                        description: 'Learn More',
                      ),
                      FeatureCard(
                        title: "Your Guide to Morroco",
                        subtitle: "Aji app is your Companion in Morocco",
                        backgroundImage: AssetImage('assets/images/guide.jpg'),
                        description: 'Learn More',
                      ),
                      FeatureCard(
                        title: "Hassan II Mosque",
                        subtitle: "Visit the Largest mosque in Morroco",
                        backgroundImage: AssetImage('assets/images/mosque.jpg'),
                        description: 'Book a Tour',
                      ),
                      FeatureCard(
                        title: "Visit Dar Naji",
                        subtitle: "Get an unmatched taset of Morroco",
                        backgroundImage:
                            AssetImage('assets/images/f-image.jpg'),
                        description: 'Book a Tour',
                      ),
                      SizedBox(
                        width: ScreenSize.width / 80,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeInRight(
                duration: Duration(milliseconds: 1000),
                child: SectionHeader(
                  title: "Services",
                  actionWidget: ServiceView(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ServicesWidget(
                rownb: 2,
              ),
              SizedBox(
                height: 20,
              ),
              FadeInRight(
                duration: Duration(milliseconds: 1000),
                child: SectionHeader(
                  title: "Coming Up",
                  actionWidget: ComingUp(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: Row(
                    spacing: ScreenSize.width / 20,
                    children: [
                      SizedBox(
                        width: ScreenSize.width / 80,
                      ),
                      Matchwidget(
                          width: ScreenSize.width / 1.3,
                          height: ScreenSize.height / 4,
                          ImagePath: "assets/images/upcomingpic1.jpg",
                          MatchTitleaway: "Comoros",
                          MatchTitlehome: "Morocco",
                          MatchDate: "Sunday, Dec 21 \n18:00",
                          Matchplace: "Sport Complexe Prince",
                          Price: "600"),
                      Matchwidget(
                          width: ScreenSize.width / 1.3,
                          height: ScreenSize.height / 4,
                          ImagePath: "assets/images/upcomingpic2.jpg",
                          MatchTitleaway: "Zambia",
                          MatchTitlehome: "Mali",
                          MatchDate: "Sunday, Dec 21 \n18:00",
                          Matchplace: "Sport Complexe Prince",
                          Price: "600"),
                      SizedBox(
                        width: ScreenSize.width / 80,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeInRight(
                duration: Duration(milliseconds: 1000),
                child: SectionHeader(
                  title: "Discover",
                  actionWidget: Discover(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: Row(
                    spacing: ScreenSize.width / 20,
                    children: [
                      SizedBox(
                        width: ScreenSize.width / 80,
                      ),
                      SiteCard(
                          title: "Mausoleum of Mohammed V",
                          backgroundImage:
                              AssetImage("assets/images/city1.png")),
                      SiteCard(
                          title: "Hassan Tower",
                          backgroundImage:
                              AssetImage("assets/images/city2.png")),
                      SiteCard(
                          title: "Hassan II Mosque",
                          backgroundImage:
                              AssetImage("assets/images/mosque.png")),
                      SiteCard(
                          title: "Hercules Caves",
                          backgroundImage:
                              AssetImage("assets/images/hercules.png")),
                      SizedBox(
                        width: ScreenSize.width / 80,
                      ),
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
