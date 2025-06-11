import 'dart:developer';

import 'package:ajiapp/services/accomodation_service/model/hotel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HotelController extends GetxController {
  // Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  final List<LatLng> positions = [];

  // Selected city filter
  RxString selectedCity = 'All Cities'.obs;
  RxList<String> cities = <String>['All Cities'].obs;

  // Observable lists for data
  final RxList<Hotel_model> hotels = <Hotel_model>[].obs;
  final RxList<Hotel_model> filteredHotels = <Hotel_model>[].obs;

  @override
  void onInit() {
    fetchHotels();
    super.onInit();
  }

  // Filter hotels by city
  void filterByCity(String city) {
    selectedCity.value = city;
    if (city == 'All Cities') {
      filteredHotels.value = hotels;
    } else {
      filteredHotels.value =
          hotels.where((hotel) => hotel.city == city).toList();
    }
  }

  Future<void> fetchHotels() async {
    try {
      isLoading.value = true;

      // Fetch all hotels at once
      final QuerySnapshot snapshot =
          await _firestore.collection('accommodations').orderBy('title').get();

      hotels.clear(); // Clear existing data
      cities.clear(); // Clear existing cities
      cities.add('All Cities'); // Add default option

      for (var doc in snapshot.docs) {
        final hotel =
            Hotel_model.fromFirestore(doc.data() as Map<String, dynamic>);
        hotels.add(hotel);

        // Add city to cities list if not already present
        if (!cities.contains(hotel.city)) {
          cities.add(hotel.city);
        }
      }

      // Sort cities alphabetically
      cities.sort((a, b) {
        if (a == 'All Cities') return -1;
        if (b == 'All Cities') return 1;
        return a.compareTo(b);
      });

      // Initialize filtered hotels
      filteredHotels.value = hotels;
    } catch (e) {
      log("Error fetching hotels: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}
