import 'package:ajiapp/services/coming-up_service/controller/comingup_controller.dart';
import 'package:ajiapp/services/discover_service/controller/discover_controller.dart';
import 'package:ajiapp/services/home/controller/home_controller.dart';
import 'package:get/get.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ComingupController());
    Get.put(DiscoverController());
  }
}
