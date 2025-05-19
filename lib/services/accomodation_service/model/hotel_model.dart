class Hotel_model{
  
  final String title;
  final String imageUrl;
  final String price;
  final String description;

  const Hotel_model({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
  });

  factory Hotel_model.fromFirestore(Map<String, dynamic> data) {
    return Hotel_model(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        price: data["price"] ?? '');
  }
}