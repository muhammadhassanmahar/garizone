import 'dart:convert';
import 'package:http/http.dart' as http;

/// 🔧 Centralized API service for Gari Zone.
/// Handles GET, POST, PUT, DELETE requests safely.
class ApiService {
  // ✅ Change this to your real backend URL
  static const String baseUrl = "https://your-api-url.com/api/";

  // ✅ Default headers (can be extended to include tokens)
  static Map<String, String> get defaultHeaders => {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

  /// 🟩 GET Request
  static Future<dynamic> get(String endpoint) async {
    final uri = Uri.parse("$baseUrl$endpoint");
    final response = await http.get(uri, headers: defaultHeaders);
    return _handleResponse(response);
  }

  /// 🟦 POST Request
  static Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse("$baseUrl$endpoint");
    final response = await http.post(
      uri,
      headers: defaultHeaders,
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  /// 🟨 PUT Request
  static Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse("$baseUrl$endpoint");
    final response = await http.put(
      uri,
      headers: defaultHeaders,
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  /// 🟥 DELETE Request
  static Future<dynamic> delete(String endpoint) async {
    final uri = Uri.parse("$baseUrl$endpoint");
    final response = await http.delete(uri, headers: defaultHeaders);
    return _handleResponse(response);
  }

  /// 🧩 Private method to handle all HTTP responses
  static dynamic _handleResponse(http.Response response) {
    try {
      final body = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return body;
      } else {
        throw Exception(
          "API Error: ${response.statusCode}\n${body is Map ? body['message'] ?? body : body}",
        );
      }
    } catch (e) {
      throw Exception("Invalid response: ${response.body}\nError: $e");
    }
  }
}
