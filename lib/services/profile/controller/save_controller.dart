import 'package:ajiapp/services/accomodation_service/model/hotel_model.dart';
import 'package:ajiapp/services/tourisme_service/model/tourism_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SaveSpotController extends GetxController {
  var savedTouristSpots = <TouristSpot>[].obs;
  var savedAccommodations = <Hotel_model>[].obs;
  Rx<bool> isLoading = true.obs;
  @override
  void onInit() {
    loadSavedPosts();
    super.onInit();
  }

  Future<void> loadSavedPosts() async {
    isLoading.value = true;
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();
      final data = userDoc.data();

      if (data == null || !data.containsKey('savedSpots')) return;

      final savedSpots = Map<String, dynamic>.from(data['savedSpots']);
      savedTouristSpots.clear();
      savedAccommodations.clear();

      for (var entry in savedSpots.entries) {
        final id = entry.key;
        final type = entry.value;

        if (type == 'Tourisme') {
          final doc = await FirebaseFirestore.instance
              .collection('tourist_spots')
              .doc(id)
              .get();
          if (doc.exists) {
            final data = doc.data() as Map<String, dynamic>;
            savedTouristSpots.add(TouristSpot.fromFirestore(data, doc.id));
          }
        } else if (type == 'Accommodation') {
          final doc = await FirebaseFirestore.instance
              .collection('accommodations')
              .doc(id)
              .get();
          if (doc.exists) {
            final data = doc.data() as Map<String, dynamic>;
            savedAccommodations.add(Hotel_model.fromFirestore(data, doc.id));
          }
        }
      }
    } finally {
      isLoading.value = false;
    }
  }
}
