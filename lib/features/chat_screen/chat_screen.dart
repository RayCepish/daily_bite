import 'package:daily_bite/core/constants/storage_keys.dart';
import 'package:daily_bite/core/widgets/text_fields/custom_text_field.dart';
import 'package:daily_bite/features/chat_screen/chat_screen_bloc/chat_screen_bloc.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:daily_bite/features/chat_screen/widgets/chat_bubble.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String welcomeText = '';

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<ChatScreenBloc>().add(SendMessageEvent(text));
    _controller.clear();
  }

  // void _saveMeal(String title) {
  //   context.read<ChatScreenBloc>().add(SaveMealEvent(title));
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text("Страву збережено")),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    context.read<ChatScreenBloc>().add(LoadInitialMessagesEvent());
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatScreenBloc, ChatScreenState>(
      listener: (context, state) async {
        final storage = getIt<FlutterSecureStorage>();

        final isVisitAppBefore =
            await storage.read(key: StorageKeys.isVisitAppBefore) != null;
        welcomeText = !isVisitAppBefore
            ? 'Start your journey to healthy eating'
            : 'What can you help me with today?';
      },
      child: BlocBuilder<ChatScreenBloc, ChatScreenState>(
        builder: (context, state) {
          _scrollToBottom();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Expanded(
                  child: (state.messages.isEmpty)
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              welcomeText,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          itemCount: state.messages.length,
                          itemBuilder: (_, index) {
                            final message = state.messages[index];
                            return Column(
                              crossAxisAlignment: message.isUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                ChatBubble(
                                  text: message.response,
                                  isUser: message.isUser,
                                ),
                              ],
                            );
                          },
                        ),
                ),
                CustomTextField(
                  fillColor: Theme.of(context).colorScheme.primaryContainer,
                  controller: _controller,
                  hintText: 'Send a message...',
                  suffixIcon: const Icon(Icons.send),
                  onSuffixTap: _sendMessage,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
