import 'dart:developer';
import 'package:ajiapp/services/discover_service/model/discover_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DiscoverController extends GetxController {
  // Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  final RxList<DiscoverModel> discovers = <DiscoverModel>[].obs;

  @override
  void onInit() {
    fetchdiscovers();
    super.onInit();
  }

  Future<void> fetchdiscovers() async {
    try {
      isLoading.value = true;

      final QuerySnapshot snapshot =
          await _firestore.collection('discovers').get();

      discovers.clear(); // Clear existing data

      for (var doc in snapshot.docs) {
        final event =
            DiscoverModel.fromFirestore(doc.data() as Map<String, dynamic>);
        discovers.add(event);
      }
    } catch (e) {
      log("Error fetching events: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}
