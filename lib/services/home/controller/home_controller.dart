// ignore_for_file: use_build_context_synchronously

import 'package:ajiapp/backend/authentification_functions.dart';
import 'package:ajiapp/routing.dart';
import 'package:ajiapp/services/home/model/feature_model.dart';
import 'package:ajiapp/utils/image_cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // State variables
  var islogged = false.obs;
  var isloading = true.obs;
  final RxList<FeatureModel> fts = <FeatureModel>[].obs;
  var loadSecondaryContent = false.obs;

  // Animation controllers
  late AnimationController animationController;
  late Animation<double> opacityAnimation;

  @override
  void onInit() {
    super.onInit();

    // Initialize animation controller
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    // Start animation
    animationController.forward();

    // Fetch data
    fetchfeatures();

    // Load secondary content after initial render
    Future.delayed(const Duration(milliseconds: 100), () {
      loadSecondaryContent.value = true;
    });

    // Precache images after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImages();
    });
  }

  // Precache important images
  Future<void> precacheImages() async {
    try {
      await ImageCacheManager.precacheCommonImages(Get.context!);
    } catch (e) {
      debugPrint('Error precaching images: $e');
    }
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
          await FirebaseFirestore.instance.collection('features').get();
      for (var doc in snapshot.docs) {
        final feature =
            FeatureModel.fromFirestore(doc.data() as Map<String, dynamic>);
        fts.add(feature);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  void showLoginBottomSheet(BuildContext context) {
    // Your existing showLoginBottomSheet implementation
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
