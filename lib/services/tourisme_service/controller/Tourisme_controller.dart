// lib/services/tourisme_service/controller/Tourisme_controller.dart

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

  // Loading states - remove shimmer states and just use loading states
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

  // Pagination variables
  final int pageSize = 5;
  DocumentSnapshot? lastTouristSpotDoc;
  DocumentSnapshot? lastTourDoc;
  final RxBool hasMoreSpots = true.obs;
  final RxBool hasMoreTours = true.obs;
  final RxBool loadingMoreSpots = false.obs;
  final RxBool loadingMoreTours = false.obs;

  @override
  void onInit() {
    // Prioritize loading cities first since they're needed for the filter
    fetchCities().then((_) {
      // Then load initial tourist spots and tours
      fetchInitialTouristSpots();
      fetchInitialTours();
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

  // Fetch initial tourist spots with pagination
  Future<void> fetchInitialTouristSpots() async {
    try {
      isLoadingSpots.value = true;

      // Clear existing data
      touristSpots.clear();
      lastTouristSpotDoc = null;
      hasMoreSpots.value = true;

      // Fetch first batch
      QuerySnapshot snapshot = await _firestore
          .collection('tourist_spots')
          .orderBy('rating', descending: true)
          .limit(pageSize)
          .get();

      if (snapshot.docs.isEmpty) {
        hasMoreSpots.value = false;
      } else {
        for (var doc in snapshot.docs) {
          touristSpots.add(TouristSpot.fromFirestore(
              doc.data() as Map<String, dynamic>, doc.id));
        }

        // Store last document for pagination
        lastTouristSpotDoc = snapshot.docs.last;
      }
    } catch (e) {
      errorSpots.value = 'Error fetching tourist spots: $e';
      print(errorSpots.value);
    } finally {
      isLoadingSpots.value = false;
    }
  }

  // The rest of your methods remain unchanged...
  // loadMoreTouristSpots, fetchInitialTours, loadMoreTours, etc.
  Future<void> loadMoreTouristSpots() async {
    if (!hasMoreSpots.value ||
        loadingMoreSpots.value ||
        touristSpots.length >= 10) return;

    try {
      loadingMoreSpots.value = true;

      QuerySnapshot snapshot = await _firestore
          .collection('tourist_spots')
          .orderBy('rating', descending: true)
          .startAfterDocument(lastTouristSpotDoc!)
          .limit(pageSize)
          .get();

      if (snapshot.docs.isEmpty) {
        hasMoreSpots.value = false;
      } else {
        for (var doc in snapshot.docs) {
          touristSpots.add(TouristSpot.fromFirestore(
              doc.data() as Map<String, dynamic>, doc.id));
        }

        lastTouristSpotDoc = snapshot.docs.last;
      }
    } catch (e) {
      print('Error loading more spots: $e');
    } finally {
      loadingMoreSpots.value = false;
    }
  }

  // Fetch initial tours with pagination
  Future<void> fetchInitialTours() async {
    try {
      isLoadingTours.value = true;

      // Clear existing data
      tours.clear();
      lastTourDoc = null;
      hasMoreTours.value = true;

      // Fetch first batch
      QuerySnapshot snapshot = await _firestore
          .collection('tours')
          .orderBy('rating', descending: true)
          .limit(pageSize)
          .get();

      if (snapshot.docs.isEmpty) {
        hasMoreTours.value = false;
      } else {
        for (var doc in snapshot.docs) {
          tours.add(
              Tour.fromFirestore(doc.data() as Map<String, dynamic>, doc.id));
        }

        // Store last document for pagination
        lastTourDoc = snapshot.docs.last;
      }
    } catch (e) {
      errorTours.value = 'Error fetching tours: $e';
      print(errorTours.value);
    } finally {
      isLoadingTours.value = false;
    }
  }

  // Load more tours
  Future<void> loadMoreTours() async {
    if (!hasMoreTours.value || loadingMoreTours.value || tours.length > 6)
      return;

    try {
      loadingMoreTours.value = true;

      QuerySnapshot snapshot = await _firestore
          .collection('tours')
          .orderBy('rating', descending: true)
          .startAfterDocument(lastTourDoc!)
          .limit(pageSize)
          .get();

      if (snapshot.docs.isEmpty) {
        hasMoreTours.value = false;
      } else {
        for (var doc in snapshot.docs) {
          tours.add(
              Tour.fromFirestore(doc.data() as Map<String, dynamic>, doc.id));
        }

        lastTourDoc = snapshot.docs.last;
      }
    } catch (e) {
      print('Error loading more tours: $e');
    } finally {
      loadingMoreTours.value = false;
    }
  }

  // Other filter and search methods remain the same
  // ...

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

  // Check if we need to load more spots (for infinite scrolling)
  void checkAndLoadMoreSpots() {
    if (!loadingMoreSpots.value && hasMoreSpots.value) {
      loadMoreTouristSpots();
    }
  }

  // Check if we need to load more tours (for infinite scrolling)
  void checkAndLoadMoreTours() {
    if (!loadingMoreTours.value && hasMoreTours.value) {
      loadMoreTours();
    }
  }
}
