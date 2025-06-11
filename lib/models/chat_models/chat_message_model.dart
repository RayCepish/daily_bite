class ChatMessageModel {
  final int? id;
  final String response;
  final DateTime? createdAt;
  final bool isUser;

  ChatMessageModel({
    this.id,
    required this.response,
    this.createdAt,
    this.isUser = false,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'],
      response: json['response'],
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      isUser: false,
    );
  }
}
