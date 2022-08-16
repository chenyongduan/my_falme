import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:my_flame/game/joypad.dart';
import 'package:my_flame/game/world_game.dart';

class MainGame extends StatefulWidget {
  const MainGame({super.key});

  @override
  State<MainGame> createState() => _MainGameState();
}

class _MainGameState extends State<MainGame> {
  WorldGame game = WorldGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GameWidget(game: game),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: JoyPad(
              onDirectionChange: game.onDirectionChange,
            ),
          ),
        ),
      ]),
    );
  }
}
