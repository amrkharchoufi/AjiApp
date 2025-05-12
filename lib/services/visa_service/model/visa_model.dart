class visa_model {
  late final String country;
  late final String Imageurl;
  late final String nationality;
  late final bool requiredvisa;

  visa_model(
      {required this.country,
      required this.Imageurl,
      required this.requiredvisa,
      required this.nationality});

  factory visa_model.fromFirestore(Map<String, dynamic> data) {
    return visa_model(
        country: data["country"] ?? "",
        Imageurl: data["imageurl"] ?? "",
        requiredvisa: data["required"] ?? false,
        nationality: data["nationality"] ?? "");
  }
}
