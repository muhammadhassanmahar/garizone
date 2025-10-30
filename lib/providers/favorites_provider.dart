import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../services/favorites_service.dart';

class FavoritesProvider with ChangeNotifier {
  List<CarModel> _favorites = [];

  List<CarModel> get favorites => _favorites;

  /// Fetch all favorite cars from the backend
  Future<void> fetchFavorites() async {
    try {
      final data = await FavoritesService.listFavorites();

      // ✅ Removed unnecessary cast
      _favorites = data.map<CarModel>((item) => CarModel.fromJson(item)).toList();

      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching favorites: $e");
    }
  }

  /// Add a car to favorites
  Future<void> addFavorite(CarModel car) async {
    try {
      await FavoritesService.addFavorite(car.id);
      _favorites.add(car);
      notifyListeners();
    } catch (e) {
      debugPrint("Error adding favorite: $e");
    }
  }

  /// Remove a car from favorites
  Future<void> removeFavorite(String carId) async {
    try {
      await FavoritesService.removeFavorite(carId);
      _favorites.removeWhere((fav) => fav.id == carId);
      notifyListeners();
    } catch (e) {
      debugPrint("Error removing favorite: $e");
    }
  }

  /// Check if a car is already in favorites
  bool isFavorite(String carId) {
    return _favorites.any((fav) => fav.id == carId);
  }
}
