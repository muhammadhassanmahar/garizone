import 'package:flutter/material.dart';
import '../services/favorites_service.dart';

class FavoritesProvider with ChangeNotifier {
  List<dynamic> _favorites = [];

  List<dynamic> get favorites => _favorites;

  Future<void> fetchFavorites() async {
    final data = await FavoritesService.listFavorites();
    _favorites = data;
    notifyListeners();
  }

  Future<void> addFavorite(String carId) async {
    await FavoritesService.addFavorite(carId);
    await fetchFavorites();
  }

  Future<void> removeFavorite(String carId) async {
    await FavoritesService.removeFavorite(carId);
    await fetchFavorites();
  }

  bool isFavorite(String carId) {
    return _favorites.any((fav) => fav["car_id"] == carId);
  }
}
