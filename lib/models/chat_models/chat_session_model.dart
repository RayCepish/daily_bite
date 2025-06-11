class ChatSessionModel {
  final int id;
  final String title;
  final DateTime createdAt;

  ChatSessionModel({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory ChatSessionModel.fromJson(Map<String, dynamic> json) {
    return ChatSessionModel(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
