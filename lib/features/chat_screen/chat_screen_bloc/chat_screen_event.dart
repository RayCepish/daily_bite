part of 'chat_screen_bloc.dart';

@immutable
sealed class ChatScreenEvent {}

class LoadInitialMessagesEvent extends ChatScreenEvent {}

class SendMessageEvent extends ChatScreenEvent {
  final String userMessage;
  SendMessageEvent(this.userMessage);
}

class SaveMealEvent extends ChatScreenEvent {
  final String message;
  SaveMealEvent(this.message);
}
