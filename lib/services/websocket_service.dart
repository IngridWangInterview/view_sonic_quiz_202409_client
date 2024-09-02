import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

class User {
  final String name;
  bool isOnline;
  List<String> messages;

  User(this.name, {this.isOnline = true, this.messages = const []});
}

class WebSocketService {
  WebSocketChannel? _channel;
  String? _name;
  final _connectionStatusController = StreamController<bool>.broadcast();

  WebSocketService();

  Stream<bool> get connectionStatus => _connectionStatusController.stream;

  Future<void> connect(String url, String name) async {
    _name = name;
    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
      _connectionStatusController.add(true);
      await _channel?.ready;
      _channel?.sink.add('{"type": "connect", "name": "$name", "content": ""}');
    } catch (e) {
      _connectionStatusController.add(false);
      rethrow;
    }
  }

  void sendMessage(String message) {
    _channel?.sink
        .add('{"type": "message", "name": "$_name", "content": "$message"}');
  }

  Future<void> disconnect() async {
    _channel?.sink
        .add('{"type": "disconnect", "name": "$_name", "content": ""}');
    await _channel?.sink.close();
    _connectionStatusController.add(false);
  }

  void dispose() {
    disconnect();
    _connectionStatusController.close();
  }
}
