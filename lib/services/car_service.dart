import 'api_service.dart';

class CarService {
  static Future<List<dynamic>> getCars() async {
    return await ApiService.get('/cars');
  }

  static Future<dynamic> addCar(Map<String, dynamic> data) async {
    return await ApiService.post('/cars/add', data);
  }

  static Future<dynamic> updateCar(String id, Map<String, dynamic> data) async {
    return await ApiService.put('/cars/update/$id', data);
  }

  static Future<dynamic> deleteCar(String id) async {
    return await ApiService.delete('/cars/delete/$id');
  }
}
