import 'api_service.dart';

class AuthService {
  static Future<dynamic> register(
      String name, String email, String password) async {
    return await ApiService.post('/auth/register', {
      "name": name,
      "email": email,
      "password": password,
    });
  }

  static Future<dynamic> login(String email, String password) async {
    return await ApiService.post('/auth/login', {
      "email": email,
      "password": password,
    });
  }
}
