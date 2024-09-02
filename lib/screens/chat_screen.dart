import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:view_sonic_quiz_202409/screens/name_input_screen.dart';

import '../providers/websocket_provider.dart';

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageController = useTextEditingController();
    final webSocketService = ref.watch(webSocketServiceProvider);

    void sendMessage() {
      if (messageController.text.isNotEmpty) {
        webSocketService.sendMessage(messageController.text);
        messageController.clear();
      }
    }

    void exit() {
      webSocketService.disconnect();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const NameInputScreen()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: exit,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: sendMessage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
