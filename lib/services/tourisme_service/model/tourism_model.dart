// lib/services/tourisme_service/model/tourism_model.dart

class TouristSpot {
  final String id;
  final String name;
  final String city;
  final String description;
  final String imageUrl;
  final String rating;
  final String ratingCount;
  final String entryFee; // "Free Entry" or "Paid Entry"
  final String interestType; // "History", "Culture", etc.
  final String openingHours; // e.g., "6:30 AM–10:45 PM"
  final String history; // Detailed historical information
  final double latitude; // For map view
  final double longitude; // For map view
  final int likescount;

  TouristSpot({
    required this.id,
    required this.name,
    required this.city,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.ratingCount,
    required this.entryFee,
    required this.interestType,
    this.openingHours = "6:30 AM–10:45 PM", // Default value
    this.history = "", // Default value
    this.latitude = 0.0, // Default value
    this.longitude = 0.0,
    this.likescount = 0, // Default value
  });

  factory TouristSpot.fromFirestore(
      Map<String, dynamic> data, String documentId) {
    return TouristSpot(
      id: documentId,
      name: data['name'] ?? '',
      city: data['city'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ??
          'https://via.placeholder.com/400x300?text=No+Image',
      rating: data['rating'] ?? '0.0',
      ratingCount: data['ratingCount'] ?? '0',
      entryFee: data['entryFee'] ?? 'Free Entry',
      interestType: data['interestType'] ?? 'Tourism',
      openingHours: data['openingHours'] ?? '6:30 AM–10:45 PM',
      history: data['history'] ?? '',
      latitude: (data['latitude'] ?? 0.0).toDouble(),
      longitude: (data['longitude'] ?? 0.0).toDouble(),
      likescount: (data['likesCount'] ?? 0).toInt(),
    );
  }
}

class Tour {
  final String id;
  final String name;
  final String startingCity;
  final String description;
  final String imageUrl;
  final String duration; // "3 days", "5 days", etc.
  final String price;
  final String rating;
  final String ratingCount;
  final List<String> cities; // Cities included in the tour

  Tour({
    required this.id,
    required this.name,
    required this.startingCity,
    required this.description,
    required this.imageUrl,
    required this.duration,
    required this.price,
    required this.rating,
    required this.ratingCount,
    required this.cities,
  });

  factory Tour.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Tour(
      id: documentId,
      name: data['name'] ?? '',
      startingCity: data['startingCity'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ??
          'https://via.placeholder.com/400x300?text=No+Image',
      duration: data['duration'] ?? '1 day',
      price: data['price'] ?? '0 MAD',
      rating: data['rating'] ?? '0.0',
      ratingCount: data['ratingCount'] ?? '0',
      cities: List<String>.from(data['cities'] ?? []),
    );
  }
}

class City {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final List<String> interests; // Available interests in this city

  City({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.interests,
  });

  factory City.fromFirestore(Map<String, dynamic> data, String documentId) {
    return City(
      id: documentId,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ??
          'https://via.placeholder.com/400x300?text=No+Image',
      description: data['description'] ?? '',
      interests: List<String>.from(data['interests'] ?? []),
    );
  }
}
