// lib/services/tourisme_service/controller/Tourisme_controller.dart
// ignore_for_file: avoid_print

import 'package:ajiapp/services/tourisme_service/model/tourism_model.dart';
import 'package:ajiapp/services/tourisme_service/view/visit_morocco_all.dart';
import 'package:ajiapp/services/tourisme_service/view/visit_morocco_home.dart';
import 'package:ajiapp/services/tourisme_service/view/visit_morroco_city.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TourismeController extends GetxController {
  // Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable lists for data
  final RxList<City> cities = <City>[].obs;
  final RxList<TouristSpot> touristSpots = <TouristSpot>[].obs;
  final RxList<Tour> tours = <Tour>[].obs;

  // Loading states
  final RxBool isLoadingCities = true.obs;
  final RxBool isLoadingSpots = true.obs;
  final RxBool isLoadingTours = true.obs;

  // Error states
  final RxString errorCities = ''.obs;
  final RxString errorSpots = ''.obs;
  final RxString errorTours = ''.obs;

  // Current view
  Widget custom = VisitMoroccoHome();

  // Selected filters
  RxString selectedCity = 'All the Country'.obs;
  RxString selectedInterest = ''.obs;

  @override
  void onInit() {
    fetchCities();
    fetchTouristSpots();
    fetchTours();
    super.onInit();
  }

  // Fetch cities from Firestore
  Future<void> fetchCities() async {
    try {
      isLoadingCities.value = true;

      // Add default "All the Country" option
      cities.add(City(
        id: 'all',
        name: 'All the Country',
        imageUrl: 'assets/images/morocco.jpg',
        description: 'Explore all of Morocco',
        interests: [],
      ));

      final QuerySnapshot snapshot =
          await _firestore.collection('cities').get();

      for (var doc in snapshot.docs) {
        cities.add(
            City.fromFirestore(doc.data() as Map<String, dynamic>, doc.id));
      }
    } catch (e) {
      errorCities.value = 'Error fetching cities: $e';
      print(errorCities.value);
    } finally {
      isLoadingCities.value = false;
    }
  }

  // Fetch tourist spots from Firestore
  Future<void> fetchTouristSpots() async {
    try {
      isLoadingSpots.value = true;

      final QuerySnapshot snapshot =
          await _firestore.collection('tourist_spots').get();

      for (var doc in snapshot.docs) {
        touristSpots.add(TouristSpot.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id));
      }
    } catch (e) {
      errorSpots.value = 'Error fetching tourist spots: $e';
      print(errorSpots.value);
    } finally {
      isLoadingSpots.value = false;
    }
  }

  // Fetch tours from Firestore
  Future<void> fetchTours() async {
    try {
      isLoadingTours.value = true;

      final QuerySnapshot snapshot = await _firestore.collection('tours').get();

      for (var doc in snapshot.docs) {
        tours.add(
            Tour.fromFirestore(doc.data() as Map<String, dynamic>, doc.id));
      }
    } catch (e) {
      errorTours.value = 'Error fetching tours: $e';
      print(errorTours.value);
    } finally {
      isLoadingTours.value = false;
    }
  }

  // Filter spots by city
  List<TouristSpot> getSpotsByCity(String city) {
    if (city == 'All the Country') {
      return touristSpots;
    }
    return touristSpots.where((spot) => spot.city == city).toList();
  }

  // Filter tours by starting city
  List<Tour> getToursByCity(String city) {
    if (city == 'All the Country') {
      return tours;
    }
    return tours
        .where(
            (tour) => tour.startingCity == city || tour.cities.contains(city))
        .toList();
  }

  // Get all city names as a list for dropdown
  List<String> get cityNames => cities.map((city) => city.name).toList();

  // Get all interest types
  List<String> get interestTypes {
    Set<String> interests = {};
    for (var city in cities) {
      interests.addAll(city.interests);
    }
    return interests.toList();
  }

  // Change view based on selected city
  void searchCity(String value) {
    selectedCity.value = value;

    if (value == "All the Country") {
      custom = VisitMoroccoAll();
    } else {
      custom = VisitMoroccoCity(city: value);
    }
    update();
  }

  // Set selected interest
  void setInterest(String value) {
    selectedInterest.value = value;
    update();
  }
}
