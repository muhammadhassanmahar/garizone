class ChatMessage {
  final String sender; // 'user' or 'ai'
  final String text;

  ChatMessage({
    required this.sender,
    required this.text,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      sender: json["sender"] ?? "user",
      text: json["text"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sender": sender,
      "text": text,
    };
  }
}
