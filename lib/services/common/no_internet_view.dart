// lib/services/common/no_internet_view.dart
import 'package:ajiapp/routing.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 80, color: Colors.grey),
              const SizedBox(height: 20),
              const Text(
                'No Internet Connection',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text('Please check your connection and try again.'),
              ElevatedButton(
                onPressed: () async {
                  Get.dialog(const Center(child: CircularProgressIndicator()),
                      barrierDismissible: false);

                  final result = await Connectivity().checkConnectivity();
                  Get.back(); // Close dialog

                  if (result != ConnectivityResult.none) {
                    Get.offAll(Routes.CLIENT_SPACE);
                  } else {
                    Get.snackbar("Error", "Still no internet connection");
                  }
                },
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
