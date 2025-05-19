class FeatureModel {
  final String title;
  final String description;
  final String Imageurl;

  const FeatureModel({
    required this.title,
    required this.description,
    required this.Imageurl,
  });

  factory FeatureModel.fromFirestore(Map<String, dynamic> data) {
    return FeatureModel(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        Imageurl: data['imageUrl'] ?? '');
  }
}
