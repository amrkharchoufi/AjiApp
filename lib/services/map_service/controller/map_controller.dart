import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ajiapp/services/accomodation_service/model/hotel_model.dart';

class MapController extends GetxController {
  /// This RxList will hold the list of Hotel_model objects.
  final RxList<Hotel_model> hotels = <Hotel_model>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;

  /// This RxList just duplicates the LatLng positions for convenience.
  final RxList<LatLng> positions = <LatLng>[].obs;

@override
  void onInit() {
    fetchallhotels();
    super.onInit();
  }

  Future<void> fetchallhotels() async {
    try {
      isLoading.value = true;

      // Initial query with limit
      final Query query = _firestore.collection('accommodations');

      final QuerySnapshot snapshot = await query.get();

      positions.clear();
      for (var doc in snapshot.docs) {
        final hotel =
            Hotel_model.fromFirestore(doc.data() as Map<String, dynamic>);
        hotels.add(hotel);
        positions.add(hotel.location);
      }
    } catch (e) {
      print("Error fetching hotels: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}
