import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ajiapp/services/accomodation_service/model/hotel_model.dart';

class MapController extends GetxController {
  /// This RxList will hold the list of Hotel_model objects.
  final RxList<Hotel_model> hotels = <Hotel_model>[].obs;
  final RxList<Hotel_model> filteredHotels = <Hotel_model>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;

  // Selected city filter
  RxString selectedCity = 'All Cities'.obs;
  RxList<String> cities = <String>['All Cities'].obs;

  /// This RxList just duplicates the LatLng positions for convenience.
  final RxList<LatLng> positions = <LatLng>[].obs;

  @override
  void onInit() {
    fetchallhotels();
    super.onInit();
  }

  // Filter hotels by city
  void filterByCity(String city) {
    selectedCity.value = city;
    if (city == 'All Cities') {
      filteredHotels.value = hotels;
      positions.value = hotels.map((hotel) => hotel.location).toList();
    } else {
      filteredHotels.value =
          hotels.where((hotel) => hotel.city == city).toList();
      positions.value = filteredHotels.map((hotel) => hotel.location).toList();
    }
  }

  Future<void> fetchallhotels() async {
    try {
      isLoading.value = true;

      // Initial query with limit
      final Query query = _firestore.collection('accommodations');

      final QuerySnapshot snapshot = await query.get();

      hotels.clear();
      positions.clear();
      cities.clear();
      cities.add('All Cities');

      for (var doc in snapshot.docs) {
        final hotel = Hotel_model.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
        hotels.add(hotel);
        positions.add(hotel.location);

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
