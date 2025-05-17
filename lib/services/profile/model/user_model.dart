class user_model {
  late final String email;
  late final String phone;
  late final String name;
  late final String country;

  user_model(
      {required this.email,
      required this.phone,
      required this.name,
      required this.country});

  factory user_model.fromFirestore(Map<String, dynamic> data) {
    return user_model(
        email: data["email"] ?? "",
        name: data["username"] ?? "",
        phone: data["phone"] ?? "",
        country: "unknown"
        // data["city"] ?? ""
        );
  }
}
