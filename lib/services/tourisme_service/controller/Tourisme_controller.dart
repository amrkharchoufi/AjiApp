// lib/services/tourisme_service/controller/Tourisme_controller.dart

// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:ajiapp/services/tourisme_service/model/tourism_model.dart';
import 'package:ajiapp/services/tourisme_service/view/visit_morocco_home.dart';
import 'package:ajiapp/services/tourisme_service/view/visit_morroco_city.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  final RxBool isinteractionloading = true.obs;
  RxMap<String, bool> likedSpots = <String, bool>{}.obs;
  RxMap<String, bool> savedSpots = <String, bool>{}.obs;
  var likeCounts = <String, RxInt>{}.obs;
  var reviews = <String, List<Map<String, dynamic>>>{}.obs;
  RxSet<String> loadedReviewSpots = <String>{}.obs;

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
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        loadUserInteractions();
      }
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
        final Spot = TouristSpot.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
        touristSpots.add(Spot);
        likeCounts[Spot.id] = RxInt(Spot.likescount);
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
      custom.value = VisitMoroccoHome();
    } else {
      custom.value = VisitMoroccoCity(city: selectedCity.value);
    }
  }

  // Clear all selected interests
  void clearInterests() {
    selectedInterests.clear();
    // Update the view with filtered results
    if (selectedCity.value == "All the Country") {
      custom.value = VisitMoroccoHome();
    } else {
      custom.value = VisitMoroccoCity(city: selectedCity.value);
    }
  }

  // Change view based on selected city
  void filterByCity(String value) {
    selectedCity.value = value;

    if (value == "All the Country") {
      custom.value = VisitMoroccoHome();
    } else {
      custom.value = VisitMoroccoCity(city: value);
    }
    update();
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
      savedSpots
          .assignAll(saved?.map((key, value) => MapEntry(key, true)) ?? {});
    }
  }

  Future<void> toggleLike(String spotId) async {
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    // Get current like status (default to false if null)
    final bool isLiked = likedSpots[spotId] ?? false;
    final bool newLikeStatus = !isLiked;

    // ✅ Update UI immediately
    likedSpots[spotId] = newLikeStatus;
    likedSpots.update(spotId, (value) => newLikeStatus,
        ifAbsent: () => newLikeStatus);

    if (likeCounts.containsKey(spotId)) {
      likeCounts[spotId]!.value += newLikeStatus ? 1 : -1;
    } else {
      likeCounts[spotId] = RxInt(newLikeStatus ? 1 : 0);
    }

    // 🕒 Continue backend updates in background
    final userRef = FirebaseFirestore.instance.collection('user').doc(userId);
    final spotRef =
        FirebaseFirestore.instance.collection("tourist_spots").doc(spotId);

    try {
      if (newLikeStatus) {
        // Firestore: like
        await userRef.set({
          'likedSpots': {spotId: true}
        }, SetOptions(merge: true));

        await spotRef.update({'likesCount': FieldValue.increment(1)});
      } else {
        // Firestore: unlike
        await userRef.update({'likedSpots.$spotId': FieldValue.delete()});

        await spotRef.update({'likesCount': FieldValue.increment(-1)});
      }
    } catch (e) {
      // ❌ Revert UI if error occurs
      likedSpots[spotId] = isLiked; // revert to old state

      if (likeCounts.containsKey(spotId)) {
        likeCounts[spotId]!.value += isLiked ? 1 : -1;
      }

      Get.snackbar('Error', 'Something went wrong. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.black);
    }
  }

  Future<void> toggleSave(String spotId) async {
    const String type = "Tourisme";
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('user').doc(userId);

    final bool isSaved = savedSpots.containsKey(spotId);
    final bool newSavedStatus = !isSaved;

    // ✅ Update UI instantly
    if (newSavedStatus) {
      savedSpots[spotId] = true;
    } else {
      savedSpots.remove(spotId);
    }

    // 🕒 Continue backend logic
    try {
      if (newSavedStatus) {
        // Firestore: Save
        await userRef.set({
          'savedSpots': {spotId: type}
        }, SetOptions(merge: true));
      } else {
        // Firestore: Unsave
        await userRef.update({'savedSpots.$spotId': FieldValue.delete()});
      }
    } catch (e) {
      // ❌ Revert UI if error occurs
      if (newSavedStatus) {
        savedSpots.remove(spotId);
      } else {
        savedSpots[spotId] = true;
      }

      Get.snackbar(
        'Error',
        'Failed to update saved post. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
    }
  }

  @override
  void onClose() {
    // Reset the custom widget when leaving the controller
    custom.value = VisitMoroccoHome();
    super.onClose();
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
        .collection("tourist_spots")
        .doc(spotId)
        .collection("reviews")
        .add(reviewData);

    // Reload after submit
    await loadReviews(spotId);
  }

  Future<void> loadReviews(String spotId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("tourist_spots")
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
