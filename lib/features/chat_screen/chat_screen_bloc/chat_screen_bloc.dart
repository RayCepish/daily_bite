import 'package:bloc/bloc.dart';
import 'package:daily_bite/core/utils/custom_try_catch.dart';
import 'package:daily_bite/models/chat_models/chat_message_model.dart';
import 'package:daily_bite/services/api/chat_api_service.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:flutter/material.dart';

part 'chat_screen_event.dart';
part 'chat_screen_state.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  final _chatService = getIt<ChatApiService>();

  ChatScreenBloc()
      : super(const ChatScreenState(
          messages: [],
        )) {
    on<LoadInitialMessagesEvent>(_onLoadInitialMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<SaveMealEvent>(_onSaveMeal);
  }

  Future<void> _onLoadInitialMessages(
    LoadInitialMessagesEvent event,
    Emitter<ChatScreenState> emit,
  ) async {
    await customTryCatch(showLoader: true, () async {
      // final sessions = await _chatService.fetchChatSessions();

      // if (sessions.isEmpty) {
      //   emit(state.copyWith(messages: []));
      //   return;
      // }

      // final firstSessionId = sessions.first.id;

      // final messages =
      //     await _chatService.fetchMessagesBySession(firstSessionId);

      // emit(state.copyWith(messages: messages));
    });
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatScreenState> emit,
  ) async {
    final userMessage = ChatMessageModel(
      response: event.userMessage,
      createdAt: DateTime.now(),
      isUser: true,
    );

    final updatedMessages = [...state.messages, userMessage];
    emit(state.copyWith(messages: updatedMessages));

    await customTryCatch(showLoader: true, () async {
      final response = await _chatService.sendMessage(event.userMessage);
      final newMessages = [...updatedMessages, response];
      emit(state.copyWith(messages: newMessages));
    });
  }

  Future<void> _onSaveMeal(
    SaveMealEvent event,
    Emitter<ChatScreenState> emit,
  ) async {
    print('🧾 Збережено страву: ${event.message}');
    // опціонально реалізувати логіку збереження
  }
}
