import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class ApiService {
  static Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}$endpoint"),
      headers: ApiConfig.defaultHeaders,
    );
    return _handleResponse(response);
  }

  static Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}$endpoint"),
      headers: ApiConfig.defaultHeaders,
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse("${ApiConfig.baseUrl}$endpoint"),
      headers: ApiConfig.defaultHeaders,
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse("${ApiConfig.baseUrl}$endpoint"),
      headers: ApiConfig.defaultHeaders,
    );
    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode} ${response.body}");
    }
  }
}
