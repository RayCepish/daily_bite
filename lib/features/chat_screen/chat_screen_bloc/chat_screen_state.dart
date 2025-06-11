part of 'chat_screen_bloc.dart';

class ChatScreenState {
  final List<ChatMessageModel> messages;

  const ChatScreenState({
    required this.messages,
  });

  ChatScreenState copyWith({
    List<ChatMessageModel>? messages,
  }) {
    return ChatScreenState(
      messages: messages ?? this.messages,
    );
  }

  static const initial = ChatScreenState(messages: []);
}
