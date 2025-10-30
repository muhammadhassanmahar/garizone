import 'api_service.dart';

class ChatService {
  static Future<dynamic> sendMessage(String message) async {
    return await ApiService.post('/ai/chat', {"message": message});
  }
}
