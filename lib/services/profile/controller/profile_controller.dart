import 'package:ajiapp/services/profile/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxBool isLoading = true.obs;
  late user_model currentuser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchuser();
    super.onInit();
  }

  Future<void> fetchuser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('user').doc(user!.uid).get();
      currentuser =
          user_model.fromFirestore(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      // print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
