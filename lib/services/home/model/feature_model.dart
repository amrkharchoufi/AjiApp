class FeatureModel {
  final String title;
  final String description;
  final String Imageurl;
  final String serviceType;
  final String featureType;
  final String externalLink;
  final String serviceItemId;
  final String serviceItemName;

  const FeatureModel(
      {required this.title,
      required this.description,
      required this.Imageurl,
      required this.serviceType,
      required this.featureType,
      required this.externalLink,
      required this.serviceItemId,
      required this.serviceItemName});

  factory FeatureModel.fromFirestore(Map<String, dynamic> data) {
    return FeatureModel(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        Imageurl: data['imageUrl'] ?? '',
        serviceType: data["serviceType"] ?? "",
        featureType: data["featureType"] ?? "",
        externalLink: data["externalLink"] ?? "",
        serviceItemId: data["serviceItemId"] ?? "",
        serviceItemName: data["serviceItemName"] ?? "");
  }
}
