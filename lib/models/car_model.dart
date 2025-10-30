class CarModel {
  final String id;
  final String name;
  final String brand;
  final String price;
  final String imageUrl;
  final String description;

  CarModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      brand: json["brand"] ?? "",
      price: json["price"] ?? "",
      imageUrl: json["image_url"] ?? "",
      description: json["description"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "brand": brand,
      "price": price,
      "image_url": imageUrl,
      "description": description,
    };
  }
}
