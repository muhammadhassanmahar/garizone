class FavoriteModel {
  final String id;
  final String carId;
  final String userId;

  FavoriteModel({
    required this.id,
    required this.carId,
    required this.userId,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json["_id"] ?? "",
      carId: json["car_id"] ?? "",
      userId: json["user_id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "car_id": carId,
      "user_id": userId,
    };
  }
}
