import 'package:ajiapp/services/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3500), () {
      Get.put(SplashController());
    });

    return Scaffold(
      body: SizedBox.expand(
        child: Lottie.asset('assets/animations/splash_AJIApp.json',
            fit: BoxFit.fill, frameRate: FrameRate.max),
      ),
    );
  }
}
