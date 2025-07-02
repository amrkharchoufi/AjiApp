import 'dart:developer';

import 'package:ajiapp/services/coming-up_service/model/comingup_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ComingupController extends GetxController {
  // Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  final RxList<ComingupModel> events = <ComingupModel>[].obs;

  @override
  void onInit() {
    fetchEvents();
    super.onInit();
  }

  Future<void> fetchEvents() async {
    try {
      isLoading.value = true;

      // Fetch all hotels at once
      final QuerySnapshot snapshot =
          await _firestore.collection('comingup').get();

      events.clear(); // Clear existing data

      for (var doc in snapshot.docs) {
        final event =
            ComingupModel.fromFirestore(doc.data() as Map<String, dynamic>);
        events.add(event);
      }
    } catch (e) {
      log("Error fetching events: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}
