import 'package:ajiapp/routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Shorter delay since we already showed the native splash
    Future.delayed(const Duration(milliseconds: 3500), () {
      _checkFirstSeen();
    });
  }

  Future<void> _checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = prefs.getBool('onboarding_completed') ?? false;

    if (!seen) {
      Get.offAllNamed(Routes.ONBOARDING);
    } else {
      Get.offAllNamed(Routes.CLIENT_SPACE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Lottie.asset('assets/animations/splash_AJIApp.json',
            fit: BoxFit.fill, frameRate: FrameRate.max, repeat: false),
      ),
    );
  }
}
