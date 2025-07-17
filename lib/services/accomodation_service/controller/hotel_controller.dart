import 'dart:developer';

import 'package:ajiapp/services/accomodation_service/model/hotel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  RxMap<String, bool> likedSpots = <String, bool>{}.obs;
  RxMap<String, bool> savedSpots = <String, bool>{}.obs;
  var likeCounts = <String, RxInt>{}.obs;
  var reviews = <String, List<Map<String, dynamic>>>{}.obs;
  RxSet<String> loadedReviewSpots = <String>{}.obs;

  // Observable lists for data
  final RxList<Hotel_model> hotels = <Hotel_model>[].obs;
  final RxList<Hotel_model> filteredHotels = <Hotel_model>[].obs;

  @override
  void onInit() {
    fetchHotels();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      loadUserInteractions();
    }
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
        final hotel = Hotel_model.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
        hotels.add(hotel);
        likeCounts[hotel.id] = RxInt(hotel.likesCount);

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

  Future<void> loadUserInteractions() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('user').doc(userId);
    final snapshot = await userRef.get();

    if (snapshot.exists) {
      final data = snapshot.data();

      final Map<String, dynamic>? liked = data?['likedSpots'];
      final Map<String, dynamic>? saved = data?['savedSpots'];

      likedSpots.assignAll(
          liked?.map((key, value) => MapEntry(key, value == true)) ?? {});
      savedSpots.assignAll(
          saved?.map((key, value) => MapEntry(key, value == true)) ?? {});
    }
  }

  Future<void> toggleLike(String spotId) async {
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    // Get current like status (default to false if null)
    final isLiked = likedSpots[spotId] ?? false;

    // Toggle local like state
    likedSpots[spotId] = !isLiked;

    // References
    final userRef = FirebaseFirestore.instance.collection('user').doc(userId);
    final spotRef =
        FirebaseFirestore.instance.collection("accommodations").doc(spotId);

    if (!isLiked) {
      // ✅ User is liking the spot
      await userRef.set({
        'likedSpots': {spotId: true}
      }, SetOptions(merge: true));

      await spotRef.update({'likesCount': FieldValue.increment(1)});

      // 🔁 Update local like count state
      if (likeCounts.containsKey(spotId)) {
        likeCounts[spotId]!.value += 1;
      } else {
        likeCounts[spotId] = RxInt(1);
      }
    } else {
      // ❌ User is unliking the spot
      await userRef.update({'likedSpots.$spotId': FieldValue.delete()});

      await spotRef.update({'likesCount': FieldValue.increment(-1)});

      // 🔁 Update local like count state
      if (likeCounts.containsKey(spotId)) {
        likeCounts[spotId]!.value =
            (likeCounts[spotId]!.value - 1).clamp(0, double.infinity).toInt();
      } else {
        likeCounts[spotId] = RxInt(0);
      }
    }
  }

  Future<void> toggleSave(String spotId) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final isSaved = savedSpots[spotId] ?? false;

    final userRef = FirebaseFirestore.instance.collection('user').doc(userId);

    if (!isSaved) {
      await userRef.set({
        'savedSpots': {spotId: true}
      }, SetOptions(merge: true));
      savedSpots[spotId] = true; // update after success
    } else {
      await userRef.update({'savedSpots.$spotId': FieldValue.delete()});
      savedSpots.remove(spotId); // or savedSpots[spotId] = false;
    }
  }

  Future<void> submitReview(
      String spotId, double rating, String comment) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection("user").doc(userId).get();

    final data = docSnapshot.data() as Map<String, dynamic>?;
    final String userName = data?['username'];

    final reviewData = {
      "userId": userId,
      "userName": userName,
      "rating": rating,
      "comment": comment,
      "timestamp": Timestamp.now(),
    };

    await FirebaseFirestore.instance
        .collection("accommodations")
        .doc(spotId)
        .collection("reviews")
        .add(reviewData);

    // Reload after submit
    await loadReviews(spotId);
  }

  Future<void> loadReviews(String spotId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("accommodations")
          .doc(spotId)
          .collection("reviews")
          .orderBy("timestamp", descending: true)
          .get();

      reviews[spotId] = snapshot.docs.map((doc) => doc.data()).toList();
      loadedReviewSpots.add(spotId); // Mark as loaded
    } catch (e) {
      print("Error loading reviews: $e");
    }
  }

  void showReviewDialog(String spotId) {
    final TextEditingController commentController = TextEditingController();
    final RxDouble rating = 3.0.obs;

    Get.defaultDialog(
      title: "Leave a Review",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      radius: 10,
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Rate your experience",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Obx(() => RatingBar.builder(
                  initialRating: rating.value,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  glow: false,
                  itemSize: 30,
                  unratedColor: Colors.grey[300],
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    rating.value = value;
                  },
                )),
            const SizedBox(height: 20),
            TextField(
              controller: commentController,
              maxLines: 4,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: "Your comment",
                hintText: "Share your thoughts...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
      textConfirm: "Submit",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.teal,
      onConfirm: () async {
        if (commentController.text.trim().isEmpty) {
          Get.snackbar("Error", "Please enter a comment.");
          return;
        }

        await submitReview(spotId, rating.value, commentController.text.trim());
        Get.back();
      },
    );
  }
}
