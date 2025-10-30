import 'package:flutter/material.dart';
import '../services/chat_service.dart';

class ChatProvider with ChangeNotifier {
  List<Map<String, String>> _messages = [];

  List<Map<String, String>> get messages => _messages;

  Future<void> sendMessage(String message) async {
    _messages.add({"sender": "user", "text": message});
    notifyListeners();

    try {
      final response = await ChatService.sendMessage(message);
      final reply = response["reply"] ?? "No response from AI.";
      _messages.add({"sender": "ai", "text": reply});
    } catch (e) {
      _messages.add({"sender": "ai", "text": "Error: Could not get response."});
    }

    notifyListeners();
  }
}
