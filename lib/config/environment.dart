import 'dart:io' show Platform;

class Environment {
  static String websocketUrl = String.fromEnvironment(
    'WEBSOCKET_URL',
    defaultValue: _defaultWebsocketUrl,
  );

  static String get _defaultWebsocketUrl {
    if (Platform.isAndroid) {
      return 'ws://10.0.2.2:8080';
    } else if (Platform.isIOS) {
      return 'ws://127.0.0.1:8080';
    } else {
      return 'ws://localhost:8080';
    }
  }
}
