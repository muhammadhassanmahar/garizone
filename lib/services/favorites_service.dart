import 'api_service.dart';

class FavoritesService {
  static Future<List<dynamic>> listFavorites() async {
    return await ApiService.get('/favorites/list');
  }

  static Future<dynamic> addFavorite(String carId) async {
    return await ApiService.post('/favorites/add', {"car_id": carId});
  }

  static Future<dynamic> removeFavorite(String carId) async {
    return await ApiService.post('/favorites/remove', {"car_id": carId});
  }
}
