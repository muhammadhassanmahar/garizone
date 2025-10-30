class ApiConfig {
  static const String baseUrl = "http://127.0.0.1:8000"; // Change to your backend URL if needed

  static const String login = "$baseUrl/auth/login";
  static const String register = "$baseUrl/auth/register";
  static const String cars = "$baseUrl/cars";
  static const String favorites = "$baseUrl/favorites";
  static const String aiChat = "$baseUrl/ai/chat";
}
