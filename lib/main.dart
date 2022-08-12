import 'package:flutter/material.dart';
import 'package:my_flame/game/main_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'flame game',
      debugShowCheckedModeBanner: false,
      home: MainGame(),
    );
  }
}
