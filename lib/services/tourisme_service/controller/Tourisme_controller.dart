// lib/services/tourisme_service/controller/Tourisme_controller.dart

// ignore_for_file: avoid_print

import 'dart:developer';

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
  final Rx<Widget> custom = Rx<Widget>(VisitMoroccoHome());

  // Selected filters
  RxString selectedCity = 'All the Country'.obs;
  RxList<String> selectedInterests = <String>[].obs;

  @override
  void onInit() {
    // Prioritize loading cities first since they're needed for the filter
    fetchCities().then((_) {
      // Then load tourist spots and tours
      fetchTouristSpots();
      fetchTours();
    });
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

  // Fetch all tourist spots
  Future<void> fetchTouristSpots() async {
    try {
      isLoadingSpots.value = true;
      touristSpots.clear();

      final QuerySnapshot snapshot = await _firestore
          .collection('tourist_spots')
          .orderBy('rating', descending: true)
          .get();

      for (var doc in snapshot.docs) {
        touristSpots.add(TouristSpot.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id));
      }
      log(touristSpots.length.toString());
    } catch (e) {
      errorSpots.value = 'Error fetching tourist spots: $e';
      print(errorSpots.value);
    } finally {
      isLoadingSpots.value = false;
    }
  }

  // Fetch all tours
  Future<void> fetchTours() async {
    try {
      isLoadingTours.value = true;
      tours.clear();

      final QuerySnapshot snapshot = await _firestore
          .collection('tours')
          .orderBy('rating', descending: true)
          .get();

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

  // Filter spots by city and interests
  List<TouristSpot> getSpotsByCityAndInterest(String city) {
    var filteredSpots = touristSpots.toList();

    // Apply city filter if not "All the Country"
    if (city != "All the Country") {
      filteredSpots = filteredSpots.where((spot) => spot.city == city).toList();
    }

    // Apply interest filter if any interest is selected and it's not "All"
    if (selectedInterests.isNotEmpty && selectedInterests.first != "All") {
      filteredSpots = filteredSpots.where((spot) {
        final spotInterests =
            spot.interestType.split(",").map((e) => e.trim()).toList();
        return spotInterests
            .contains(selectedInterests.first); // Since it's single-select now
      }).toList();
    }

    return filteredSpots;
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
  List<String> get cityNames {
    var names = cities.map((city) => city.name).toList();
    names.sort((a, b) {
      if (a == "All the Country") return -1;
      if (b == "All the Country") return 1;
      return a.compareTo(b);
    });
    return names;
  }

  // Get all interest types
  List<String> get interestTypes {
    Set<String> interests = {"All"};
    for (var spot in touristSpots) {
      interests.addAll(spot.interestType.split(",").map((e) => e.trim()));
    }
    var interestList = interests.toList();
    interestList.sort((a, b) {
      if (a == "All") return -1;
      if (b == "All") return 1;
      return a.compareTo(b);
    });
    return interestList;
  }

  // Toggle interest selection
  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests
          .clear(); // Clear previous selection since it's single-select
      selectedInterests.add(interest);
    }

    // Update the view with filtered results
    if (selectedCity.value == "All the Country") {
      custom.value = VisitMoroccoAll();
    } else {
      custom.value = VisitMoroccoCity(city: selectedCity.value);
    }
  }

  // Clear all selected interests
  void clearInterests() {
    selectedInterests.clear();
    // Update the view with filtered results
    if (selectedCity.value == "All the Country") {
      custom.value = VisitMoroccoAll();
    } else {
      custom.value = VisitMoroccoCity(city: selectedCity.value);
    }
  }

  // Change view based on selected city
  void filterByCity(String value) {
    selectedCity.value = value;

    if (value == "All the Country") {
      custom.value = VisitMoroccoAll();
    } else {
      custom.value = VisitMoroccoCity(city: value);
    }
    update();
  }
}
