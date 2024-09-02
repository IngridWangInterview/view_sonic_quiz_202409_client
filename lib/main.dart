import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:view_sonic_quiz_202409/screens/name_input_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebSocket Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NameInputScreen(),
    );
  }
}
