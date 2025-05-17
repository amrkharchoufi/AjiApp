import 'package:ajiapp/services/home/controller/home_controller.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/services/common/ComingUp_view.dart';
import 'package:ajiapp/services/common/Discover_view.dart';
import 'package:ajiapp/services/common/Service_view.dart';
import 'package:ajiapp/services/common/notification_view.dart';
import 'package:ajiapp/utils/image_cache_manager.dart';
import 'package:ajiapp/utils/svg_cache.dart';
import 'package:ajiapp/widgets/matches_widget.dart';
import 'package:ajiapp/widgets/morrcandoor_widget.dart';
import 'package:ajiapp/widgets/section_header.dart';
import 'package:ajiapp/widgets/services_widget.dart';
import 'package:ajiapp/widgets/sitecard_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Animation controller for smooth page transitions
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  // Lazily load content to improve initial render performance
  bool _loadSecondaryContent = false;

  @override
  void initState() {
    super.initState();

    // Initialize screen dimensions
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenSize.init(context);
      SizeConfig().init(context);

      // Precache images with valid context after widget is built
      _precacheImages();
    });

    // Setup animation controller with a shorter duration
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    // Start the animation
    _animationController.forward();

    // Load secondary content after initial render is complete
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _loadSecondaryContent = true;
        });
      }
    });
  }

  // Precache important images to improve performance
  Future<void> _precacheImages() async {
    try {
      await ImageCacheManager.precacheCommonImages(context);
    } catch (e) {
      debugPrint('Error precaching images: $e');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      body: FadeTransition(
        opacity: _opacityAnimation,
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
                _buildFeaturedSection(),

                // Secondary content - conditionally loaded
                if (_loadSecondaryContent) ...[
                  const SizedBox(height: 20),
                  _buildServicesSection(),
                  const SizedBox(height: 20),
                  _buildComingUpSection(),
                  const SizedBox(height: 20),
                  _buildDiscoverSection(),
                ]
              ],
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
  Widget _buildFeaturedSection() {
    return Column(
      children: [
        const SectionHeader(title: "Featured"),
        const SizedBox(height: 15),
        SizedBox(
          height: ScreenSize.height / 4,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: ScreenSize.width/20,
              children: const [
                SizedBox(width: 10),
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
                  backgroundImage: AssetImage('assets/images/matchday.jpg'),
                  description: 'Learn More',
                ),
                SizedBox(width: 10),
              ],
            ),
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
          child:SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
             spacing: ScreenSize.width/20,
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
            child:SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
             spacing: ScreenSize.width/20,
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
        )
        ),
      ],
    );
  }
}
