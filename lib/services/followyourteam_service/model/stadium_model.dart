class StadiumModel {
  final String name;
  final String city;
  final String imageUrl;
  final String capacity;
  final String description;
  final String inauguration;
  final String homeGroundFor;
  final double latitude; // For map view
  final double longitude; // For map view

  StadiumModel({
    required this.name,
    required this.city,
    required this.imageUrl,
    required this.capacity,
    required this.description,
    required this.inauguration,
    required this.homeGroundFor,
    this.latitude = 0.0, // Default value
    this.longitude = 0.0,
  });

  factory StadiumModel.fromFirestore(Map<String, dynamic> data) {
    return StadiumModel(
      name: data['title'] ?? "empty",
      city: data['location'] ?? "empty",
      imageUrl: data['imageUrl'],
      capacity: data["capacity"] ?? "empty",
      description: data["description"] ?? "empty",
      inauguration: data["inauguration"] ?? "empty",
      homeGroundFor: data["homeGroundFor"] ?? "empty",
      latitude: (data['latitude'] ?? 0.0).toDouble(),
      longitude: (data['longitude'] ?? 0.0).toDouble(),
    );
  }
}
