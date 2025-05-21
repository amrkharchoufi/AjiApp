import 'package:ajiapp/services/home/controller/home_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/services/common/ComingUp_view.dart';
import 'package:ajiapp/services/common/Discover_view.dart';
import 'package:ajiapp/services/common/Service_view.dart';
import 'package:ajiapp/services/common/notification_view.dart';
import 'package:ajiapp/utils/svg_cache.dart';
import 'package:ajiapp/widgets/matches_widget.dart';
import 'package:ajiapp/widgets/morrcandoor_widget.dart';
import 'package:ajiapp/widgets/section_header.dart';
import 'package:ajiapp/widgets/services_widget.dart';
import 'package:ajiapp/widgets/shimmer_door_widget.dart';
import 'package:ajiapp/widgets/sitecard_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize and find the controller
    

    ScreenSize.init(context);
    SizeConfig().init(context);

    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) => FadeTransition(
          opacity: controller.opacityAnimation,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  // Header section - always loaded immediately
                  _buildHeader(controller, context),
          
                  const SizedBox(height: 30),
          
                  // Featured section - always loaded immediately
                  _buildFeaturedSection(controller),
          
                  // Secondary content - conditionally loaded
                  Obx(() => controller.loadSecondaryContent.value
                      ? Column(
                          children: [
                            const SizedBox(height: 20),
                            _buildServicesSection(),
                            const SizedBox(height: 20),
                            _buildComingUpSection(),
                            const SizedBox(height: 20),
                            _buildDiscoverSection(),
                          ],
                        )
                      : SizedBox())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  // Build the header section with optimized SVG loading
  Widget _buildHeader(HomeController controller, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SvgCache.getAsset("assets/icons/aji_icon.svg"),
              const SizedBox(width: 5),
              const Text(
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
                      builder: (context) => const NotificationView(),
                    ),
                  );
                },
                child: Icon(
                  Icons.notifications_outlined,
                  color: ajired,
                  size: ScreenSize.width / 12,
                ),
              ),
              const SizedBox(width: 10),
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
    );
  }

  // Build the featured section with optimized content
  Widget _buildFeaturedSection(HomeController controller) {
    return Column(
      children: [
        const SectionHeader(title: "Featured"),
        const SizedBox(height: 15),
        SizedBox(
          height: ScreenSize.height / 4,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() {
              if (controller.isloading.value) {
                return Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 10 : ScreenSize.width / 20,
                        right: index == 4 ? 10 : 0,
                      ),
                      child: const ShimmerDoorCard(),
                    );
                  }),
                );
              } else {
                return Row(
                  spacing: ScreenSize.width / 20,
                  children: [
                    const SizedBox(width: 10),
                    ...controller.fts.map((ft) {
                      return FeatureCard(
                        title: ft.title,
                        subtitle: ft.description,
                        backgroundImage: ft.Imageurl,
                        description: "Learn More",
                      );
                    }),
                    const SizedBox(width: 10),
                  ],
                );
              }
            }),
          ),
        ),
      ],
    );
  }

  // Build the services section with optimized widget
  Widget _buildServicesSection() {
    return Column(
      children: [
        SectionHeader(
          title: "Services",
          actionWidget: ServiceView(),
        ),
        const SizedBox(height: 15),
        ServicesWidget(rownb: 2),
      ],
    );
  }

  // Build the coming up section with optimized list
  Widget _buildComingUpSection() {
    return Column(
      children: [
        SectionHeader(
          title: "Coming Up",
          actionWidget: ComingUp(),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: ScreenSize.height / 4,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: ScreenSize.width / 20,
              children: [
                const SizedBox(width: 10),
                Matchwidget(
                  key: const ValueKey('match1'),
                  width: ScreenSize.width / 1.3,
                  height: ScreenSize.height / 4,
                  ImagePath: "assets/images/upcomingpic1.jpg",
                  MatchTitleaway: "Comoros",
                  MatchTitlehome: "Morocco",
                  MatchDate: "Sunday, Dec 21 \n18:00",
                  Matchplace: "Sport Complexe Prince",
                  Price: "600",
                ),
                Matchwidget(
                  key: const ValueKey('match2'),
                  width: ScreenSize.width / 1.3,
                  height: ScreenSize.height / 4,
                  ImagePath: "assets/images/upcomingpic2.jpg",
                  MatchTitleaway: "Zambia",
                  MatchTitlehome: "Mali",
                  MatchDate: "Sunday, Dec 21 \n18:00",
                  Matchplace: "Sport Complexe Prince",
                  Price: "600",
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Build the discover section with optimized list
  Widget _buildDiscoverSection() {
    return Column(
      children: [
        SectionHeader(
          title: "Discover",
          actionWidget: Discover(),
        ),
        const SizedBox(height: 15),
        SizedBox(
            height: ScreenSize.height / 3.8,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: ScreenSize.width / 20,
                children: [
                  SizedBox(width: 10),
                  SiteCard(
                    title: "Mausoleum of Mohammed V",
                    backgroundImage: AssetImage("assets/images/city1.png"),
                  ),
                  SiteCard(
                    title: "Hassan Tower",
                    backgroundImage: AssetImage("assets/images/city2.png"),
                  ),
                  SiteCard(
                    title: "Hassan II Mosque",
                    backgroundImage: AssetImage("assets/images/mosque.png"),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            )),
      ],
    );
  }
}
