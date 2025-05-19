// ignore_for_file: avoid_print

import 'package:ajiapp/services/accomodation_service/model/hotel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HotelController extends GetxController {
  // Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isloading = true.obs;

  // Observable lists for data
  final RxList<String> cities = <String>[].obs;
  final RxList<Hotel_model> hotels = <Hotel_model>[].obs;

  @override
  void onInit() {
    fetchhotels();
    super.onInit();
  }

  
  Future<void> fetchhotels() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('accommodations').get();
      for (var doc in snapshot.docs) {
        final hotel =
             Hotel_model.fromFirestore(doc.data() as Map<String, dynamic>);
        hotels.add(hotel);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}
