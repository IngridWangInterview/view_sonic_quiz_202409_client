import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:view_sonic_quiz_202409/providers/websocket_provider.dart';
import 'package:view_sonic_quiz_202409/screens/chat_screen.dart';

class NameInputScreen extends HookConsumerWidget {
  const NameInputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final urlController = useTextEditingController(text: "ws://127.0.0.1:8080");
    final isLoading = useState(false);

    void connect() async {
      if (nameController.text.isEmpty) return;

      isLoading.value = true;
      final webSocketService = ref.read(webSocketServiceProvider);

      try {
        await webSocketService.connect(urlController.text, nameController.text);
        if (!context.mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ChatScreen()),
        );
      } catch (e) {
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Connection Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading.value
            ? const Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Connecting...'),
                ],
              ))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: urlController,
                    decoration: const InputDecoration(
                      labelText: 'WebSocket URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: isLoading.value ? null : connect,
                    child: const Text('Connect'),
                  ),
                ],
              ),
      ),
    );
  }
}
