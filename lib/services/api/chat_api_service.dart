import 'dart:convert';
import 'package:daily_bite/models/chat_models/chat_message_model.dart';
import 'package:daily_bite/models/chat_models/chat_session_model.dart';
import 'package:dio/dio.dart';
import 'package:daily_bite/core/constants/app_const_service.dart';

import 'package:get_it/get_it.dart';

class ChatApiService {
  final Dio dio = GetIt.instance<Dio>();
  final String baseUrl = AppConstService.baseUrl;

  Future<List<ChatMessageModel>> fetchChatHistory() async {
    final response = await dio.get('$baseUrl/api/chat/');

    final data = response.data as List;
    return data.map((e) => ChatMessageModel.fromJson(e)).toList();
  }

  Future<ChatMessageModel> sendMessage(String message) async {
    final response = await dio.post(
      '$baseUrl/api/chat/',
      data: jsonEncode(
        {
          "message": message,
        },
      ),
      options: Options(contentType: 'application/json'),
    );
    return ChatMessageModel.fromJson(response.data);
  }

  Future<List<ChatSessionModel>> fetchChatSessions() async {
    final response = await dio.get('$baseUrl/api/chat/sessions/');
    final data = response.data as List;
    return data.map((e) => ChatSessionModel.fromJson(e)).toList();
  }

  Future<List<ChatMessageModel>> fetchMessagesBySession(int sessionId) async {
    final response =
        await dio.get('$baseUrl/api/chat/sessions/$sessionId/messages/');
    final data = response.data as List;
    return data.map((e) => ChatMessageModel.fromJson(e)).toList();
  }
}
