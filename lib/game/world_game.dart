import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:my_flame/constants/player.dart';
import 'package:my_flame/game/player.dart';
import 'package:my_flame/game/world_map.dart';

class WorldGame extends FlameGame with KeyboardEvents {
  final Player _player = Player();
  final WorldMap _worldMap = WorldMap();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_worldMap);
    add(_player);

    _player.setWorldSize(_worldMap.size);
    _player.position = _worldMap.size / 2;
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _worldMap.size.x, _worldMap.size.y));
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;
    PlayerDirection playerDirection = PlayerDirection.none;

    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      playerDirection = PlayerDirection.up;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      playerDirection = PlayerDirection.down;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      playerDirection = PlayerDirection.left;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      playerDirection = PlayerDirection.right;
    }

    if (isKeyDown) {
      _player.setDirection(playerDirection);
    } else {
      _player.setDirection(PlayerDirection.none);
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
