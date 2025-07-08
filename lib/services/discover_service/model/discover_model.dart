class DiscoverModel {
  final String imageUrl;
  final String name;

  DiscoverModel({
    required this.name,
    required this.imageUrl,
  });

  factory DiscoverModel.fromFirestore(Map<String, dynamic> data) {
    return DiscoverModel(
      imageUrl: data['imageUrl'],
      name: data["cityName"] ?? "empty",
    );
  }
}
