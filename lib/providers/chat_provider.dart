import 'package:flutter/material.dart';
import '../services/chat_service.dart';

class ChatProvider with ChangeNotifier {
  final List<Map<String, String>> _messages = [];

  List<Map<String, String>> get messages => List.unmodifiable(_messages);

  /// ✅ Sends a message, gets AI reply, and updates the message list
  Future<void> sendMessage(String message) async {
    // Add user message
    _messages.add({"sender": "user", "text": message});
    notifyListeners();

    try {
      // Send message to backend or AI service
      final response = await ChatService.sendMessage(message);

      // Handle AI response safely
      final reply = response["reply"]?.toString() ?? "No response from AI.";
      _messages.add({"sender": "ai", "text": reply});
    } catch (e) {
      // Handle any errors
      _messages.add({"sender": "ai", "text": "Error: Could not get response."});
    }

    notifyListeners();
  }

  /// ✅ Optional helper method to clear chat
  void clearChat() {
    _messages.clear();
    notifyListeners();
  }
}
