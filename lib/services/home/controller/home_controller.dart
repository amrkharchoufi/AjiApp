// ignore_for_file: use_build_context_synchronously

import 'package:ajiapp/backend/authentification_functions.dart';
import 'package:ajiapp/routing.dart';
import 'package:ajiapp/services/auth/login/view/bottom_login_view.dart';
import 'package:ajiapp/services/home/model/feature_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var islogged = false.obs;
  var isloading = true.obs;
  final RxList<FeatureModel> fts = <FeatureModel>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void onInit() {
    fetchfeatures();
    super.onInit();
  }

  void showLoginBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: LoginBottomSheetView(),
        );
      },
    );
  }

  void checklogin(BuildContext context) async {
    islogged.value = await checkIfUserIsLoggedIn();
    isloading.value = false;
    if (islogged.value) {
      Get.toNamed(Routes.PROFILE);
    } else {
      showLoginBottomSheet(context);
    }
  }

  Future<void> fetchfeatures() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('features').get();
      for (var doc in snapshot.docs) {
        final visa =
            FeatureModel.fromFirestore(doc.data() as Map<String, dynamic>);
        fts.add(visa);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}
