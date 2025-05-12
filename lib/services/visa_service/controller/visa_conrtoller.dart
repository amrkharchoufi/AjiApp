// ignore_for_file: avoid_print

import 'package:ajiapp/routing.dart';
import 'package:ajiapp/services/visa_service/model/visa_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class VisaConrtoller extends GetxController {
  final RxBool isLoading = true.obs;
  late visa_model selectedvisa;
  final RxList<visa_model> visas = <visa_model>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> nationalities = [];
  @override
  void onInit() {
    fetchnationalities();
    super.onInit();
  }

  Future<void> fetchnationalities() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('visa').get();
      for (var doc in snapshot.docs) {
        final visa =
            visa_model.fromFirestore(doc.data() as Map<String, dynamic>);
        visas.add(visa);
        nationalities.add(visa.country);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      nationalities.sort((a, b) => a.compareTo(b));
      isLoading.value = false;
    }
  }

  void searchNationality(String value) {
    selectedvisa = visas.firstWhere(
      (visa) => visa.country == value,
    );
    if (selectedvisa.requiredvisa != true) {
      Get.toNamed(Routes.WITHOUT_VISA);
    } else {
      Get.toNamed(Routes.WITH_VISA);
    }
  }
}
