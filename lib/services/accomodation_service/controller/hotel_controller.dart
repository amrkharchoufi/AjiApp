// ignore_for_file: avoid_print

import 'package:ajiapp/services/accomodation_service/model/hotel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HotelController extends GetxController {
  // Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var hasMoreData = true.obs;
  final List positions = [];
  // Pagination variables
  final int pageSize = 10; // Increased page size for better performance
  DocumentSnapshot? lastDocument;

  // Observable lists for data
  final RxList<Hotel_model> hotels = <Hotel_model>[].obs;

  // Throttle for scroll loading
  DateTime? lastLoadTime;

  @override
  void onInit() {
    fetchHotels();
    super.onInit();
  }

  Future<void> fetchHotels() async {
    try {
      isLoading.value = true;

      // Initial query with limit
      final Query query = _firestore
          .collection('accommodations')
          .orderBy('title') // Adding ordering for consistent pagination
          .limit(pageSize);

      final QuerySnapshot snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        hasMoreData.value = false;
      } else {
        hotels.clear(); // Clear existing data when fetching fresh

        for (var doc in snapshot.docs) {
          final hotel =
              Hotel_model.fromFirestore(doc.data() as Map<String, dynamic>);
          positions.add(hotel.location);
          hotels.add(hotel);
        }

        // Store the last document for pagination
        if (snapshot.docs.length < pageSize) {
          hasMoreData.value = false;
        } else {
          lastDocument = snapshot.docs.last;
        }
      }
    } catch (e) {
      print("Error fetching hotels: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreHotels() async {
    // Throttle requests - don't allow more than one request per second
    final now = DateTime.now();
    if (lastLoadTime != null &&
        now.difference(lastLoadTime!).inMilliseconds < 1000) {
      return;
    }
    lastLoadTime = now;

    if (!hasMoreData.value || isLoadingMore.value) return;

    try {
      isLoadingMore.value = true;

      // Query for the next page
      final Query query = _firestore
          .collection('accommodations')
          .orderBy('title') // Same ordering as initial query
          .startAfterDocument(lastDocument!)
          .limit(pageSize);

      final QuerySnapshot snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        hasMoreData.value = false;
      } else {
        for (var doc in snapshot.docs) {
          final hotel =
              Hotel_model.fromFirestore(doc.data() as Map<String, dynamic>);
          hotels.add(hotel);
        }

        // Update the last document and check if we have more data
        if (snapshot.docs.length < pageSize) {
          hasMoreData.value = false;
        } else {
          lastDocument = snapshot.docs.last;
        }
      }
    } catch (e) {
      print("Error loading more hotels: ${e.toString()}");
    } finally {
      isLoadingMore.value = false;
    }
  }
}
