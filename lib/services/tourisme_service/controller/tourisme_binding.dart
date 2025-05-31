import 'package:get/get.dart';
import 'package:ajiapp/services/tourisme_service/controller/Tourisme_controller.dart';

class TourismeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TourismeController());
  }
}
