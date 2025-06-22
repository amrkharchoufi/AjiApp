import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ajiapp/routing.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController1 = PageController();
  final PageController pageController2 = PageController();

  // Onboarding screen data
  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Turn your travel plans into reality',
      'subtitle':
          'Discover what Morocco offers, from the rich culture, food, history, events hosted, and many more right from your phone. ',
      'image': 'assets/images/onboarding1.png',
    },
    {
      'title': 'Never miss the matches of your favorite team',
      'subtitle':
          'Follow your team around as they plays in Moroccan stadiums. Find out the details of where and where they are playing next and book your ticket right through the app.',
      'image': 'assets/images/onboarding2.png',
    },
    {
      'title': 'Stay connected',
      'subtitle':
          'Get your e-sim directly from AJI and benefit from the best cellular data once you step foot in Morocco.',
      'image': 'assets/images/onboarding3.png',
    },
    {
      'title': 'No hassle information',
      'subtitle':
          "Don't know where to go in Morocco? We got you covered! Whatever kind of tourist you are, Morocco has it all, and AJIAPP is here to guide you!",
      'image': 'assets/images/onboardingfinal.jpg',
    },
  ];

  // For next button functionality
  void nextPage() {
    if (currentPage.value == onboardingData.length - 1) {
      // Handle finish
      skipOnboarding();
    } else {
      pageController1.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      pageController2.jumpToPage(currentPage.value);
    }
  }

  // For skip button functionality
  void skipOnboarding() async {
    await completeOnboarding();
  }

  // Save completion status and navigate to appropriate screen
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    Get.offAllNamed(Routes.CLIENT_SPACE);
  }

  // Dispose of page controller
  @override
  void onClose() {
    pageController1.dispose();
    pageController2.dispose();
    super.onClose();
  }
}
