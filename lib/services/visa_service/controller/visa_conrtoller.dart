import 'package:ajiapp/routing.dart';
import 'package:get/get.dart';

class VisaConrtoller extends GetxController {
  var selectedNationality = '';
  final Map<String, String> nationalitiesMap = {
    "Algeria": "Algerian",
    "Benin": "Beninese",
    "Cameroon": "Cameroonian",
    "Egypt": "Egyptian",
    "Ghana": "Ghanaian",
    "Ivory Coast": "Ivorian",
    "Morocco": "Moroccan",
    "Senegal": "Senegalese",
  };

  final List<String> nationalities = [
    "Algeria",
    "Benin",
    "Cameroon",
    "Egypt",
    "Ghana",
    "Ivory Coast",
    "Morocco",
    "Senegal",
  ];

  final Map<String, bool> nationalityvisa = {
    "Algeria": true,
    "Benin": false,
    "Cameroon": false,
    "Egypt": true,
    "Ghana": false,
    "Ivory Coast": false,
    "Morocco": true,
    "Senegal": false,
  };

  void searchNationality(String value) {
    selectedNationality = value;
    if (nationalityvisa[value] == true) {
      Get.toNamed(Routes.WITHOUT_VISA);
    } else {
      Get.toNamed(Routes.WITH_VISA);
    }
  }
}
