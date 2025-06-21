class StadiumModel {
  final String name;
  final String city;
  final String imageUrl;
  final String capacity;
  final String description;
  final String inauguration;
  final String homeGroundFor;

  StadiumModel(
      {required this.name,
      required this.city,
      required this.imageUrl,
      required this.capacity,
      required this.description,
      required this.inauguration,
      required this.homeGroundFor});

  factory StadiumModel.fromFirestore(Map<String, dynamic> data) {
    return StadiumModel(
        name: data['title'] ?? "",
        city: data['location'] ?? "",
        imageUrl: data['imageUrl'],
        capacity: data["capacity"] ?? "",
        description: data["description"] ?? "",
        inauguration: data["inauguration"] ?? "",
        homeGroundFor: data["homeGroundFor"] ?? "");
  }
}
