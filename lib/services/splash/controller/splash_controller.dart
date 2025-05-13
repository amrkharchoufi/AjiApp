import 'package:ajiapp/routing.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    checkFirstSeen();
    super.onInit();
  }

  Future<void> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? seen = prefs.getBool('onboarding_completed');

    if (seen == null || seen == false) {
      // User has not completed onboarding
      Get.offAllNamed(Routes.ONBOARDING);
    } else {
      // User has completed onboarding
      Get.offAllNamed(Routes.CLIENT_SPACE);
    }
  }
}
