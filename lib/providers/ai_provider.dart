import 'package:flutter/foundation.dart';

class AIProvider with ChangeNotifier {
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  List<Map<String, String>> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String query) async {
    _messages.add({'sender': 'user', 'text': query});
    _isLoading = true;
    notifyListeners();

    // Simulate AI response (replace this with backend call)
    await Future.delayed(const Duration(seconds: 2));
    final response = _generateAIResponse(query);

    _messages.add({'sender': 'ai', 'text': response});
    _isLoading = false;
    notifyListeners();
  }

  String _generateAIResponse(String query) {
    // Dummy AI logic – replace with your API service call later
    if (query.toLowerCase().contains('car')) {
      return "There are many great cars available — what type are you looking for?";
    } else if (query.toLowerCase().contains('price')) {
      return "The average price range depends on the model and year of the car.";
    } else {
      return "I'm your AI car assistant — ask me anything about cars!";
    }
  }
}
