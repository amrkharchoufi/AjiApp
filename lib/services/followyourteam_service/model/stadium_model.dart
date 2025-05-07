class StadiumModel {
  String? name;
  String? city;
  String? imageUrl;

  StadiumModel({
    this.name,
    this.city,
    this.imageUrl,
  });

  StadiumModel.fromJson(Map<String, dynamic> json) {
    
    name = json['name'];
    city = json['city'];
  
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
  
    data['name'] = name;
    data['city'] = city;
  
    data['image_url'] = imageUrl;
    return data;
  }
}