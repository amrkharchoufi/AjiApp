class StadiumModel {
  final String name;
  final String city;
  final String imageUrl;
  final String capacity;
  final String description;
  final String inauguration;
  final String homeGroundFor;
  final double latitude;
  final double longitude;
  final int apiVenueId;

  StadiumModel({
    required this.name,
    required this.apiVenueId,
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
      apiVenueId: data['apiVenueId'] ?? 0,
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
