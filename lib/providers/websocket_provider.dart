import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/websocket_service.dart';

final webSocketServiceProvider = Provider((ref) {
  final service = WebSocketService();
  ref.onDispose(() => service.dispose());
  return service;
});
