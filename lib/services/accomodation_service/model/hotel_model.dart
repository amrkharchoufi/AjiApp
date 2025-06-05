import 'package:google_maps_flutter/google_maps_flutter.dart';

class Hotel_model {
  final String title;
  final String imageUrl;
  final String price;
  final String description;
  final String city;
  final LatLng location;

  const Hotel_model(
      {required this.title,
      required this.imageUrl,
      required this.price,
      required this.description,
      required this.city,
      required this.location});

  factory Hotel_model.fromFirestore(Map<String, dynamic> data) {
  final num rawLat = data["latitude"] ?? 0;
  final num rawLng = data["longitude"] ?? 0;

  return Hotel_model(
    title: data['title']       ?? '',
    description: data['description'] ?? '',
    imageUrl: data['imageUrl'] ?? '',
    price: data["price"]       ?? '',
    city: data["city"]         ?? '',
    location: LatLng(
      rawLat.toDouble(),
      rawLng.toDouble(),
    ),
  );
}
}
