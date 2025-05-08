import 'package:ajiapp/services/tourisme_service/view/visit_morocco_all.dart';
import 'package:ajiapp/services/tourisme_service/view/visit_morocco_home.dart';
import 'package:ajiapp/services/tourisme_service/view/visit_morroco_city.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TourismeController extends GetxController {
  final List<String> cities = [
    "All the Country",
    "Rabat",
    "Marrakech ",
    "Casanlanca",
    "Tangier",
    "Fes",
    "Essaouira",
  ];
  Widget Custom = VisitMoroccoHome();

  void searchCity(String value) {
    if (value == "All the Country") {
           Custom = VisitMoroccoAll();
           
    }else{
      Custom = VisitMoroccoCity(city: value);
    }
    update();
  }
}
