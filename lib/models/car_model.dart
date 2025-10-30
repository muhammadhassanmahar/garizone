class CarModel {
  final String id;
  final String name;
  final String brand;
  final String price;
  final String imageUrl;
  final String description;
  final String year; // ✅ Added missing field

  CarModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.year,
  });

  /// ✅ Factory constructor for creating an instance from JSON
  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json["_id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      brand: json["brand"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      imageUrl: json["image_url"]?.toString() ?? "",
      description: json["description"]?.toString() ?? "",
      year: json["year"]?.toString() ?? "", // ✅ Safely handles missing year
    );
  }

  /// ✅ Converts the model back to JSON
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "brand": brand,
      "price": price,
      "image_url": imageUrl,
      "description": description,
      "year": year,
    };
  }
}
