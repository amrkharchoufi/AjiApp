import 'package:ajiapp/services/followyourteam_service/model/fixture_model.dart';
import 'package:get/get.dart';

class TeamDetailsController extends GetxController {
  late int season;
  late int leagueid;
  late FixtureSimple fixture;
  late String api_token;

  Rx<int> tabIndex = 0.obs;

  @override
  void onInit() {
    season = Get.arguments['season'];
    leagueid = Get.arguments['leagueid'];
    fixture = Get.arguments['fixture'];
    api_token = Get.arguments['api_token'];
    super.onInit();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
