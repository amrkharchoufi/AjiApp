import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HotelController extends GetxController {
  // Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isloading = true.obs;

  // Observable lists for data
  final RxList<String> cities = <String>[].obs;
  final RxList<hotel_model> hotels = <hotel_model>[].obs;

  Future<void> fetchhotels() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('features').get();
      for (var doc in snapshot.docs) {
        final hotel =
            hotel_model.fromFirestore(doc.data() as Map<String, dynamic>);
        hotels.add(hotel);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}
