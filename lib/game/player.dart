import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:my_flame/constants/player.dart';

class Player extends SpriteAnimationComponent with HasGameRef {
  final _playerSpeed = 400;
  final _animationSpeed = 0.15;
  PlayerDirection _playerDirection = PlayerDirection.none;
  var worldSize = Vector2(0, 0);

  late SpriteAnimation _runUpAnimation;
  late SpriteAnimation _runDownAnimation;
  late SpriteAnimation _runLeftAnimation;
  late SpriteAnimation _runRightAnimation;
  late SpriteAnimation _standingAnimation;

  Player() : super(size: Vector2.all(50.0));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadAnimation();
    animation = _standingAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _movePlayer(dt);
  }

  setWorldSize(Vector2 outWorldSize) {
    worldSize = outWorldSize;
  }

  setDirection(PlayerDirection direction) {
    _playerDirection = direction;
  }

  _movePlayer(double delta) {
    if (_playerDirection == PlayerDirection.up) {
      animation = _runUpAnimation;
      if (position.y > 0) {
        position.add(Vector2(0, delta * -_playerSpeed));
      }
    } else if (_playerDirection == PlayerDirection.down) {
      animation = _runDownAnimation;
      if (position.y < worldSize.y - size.y) {
        position.add(Vector2(0, delta * _playerSpeed));
      }
    } else if (_playerDirection == PlayerDirection.left) {
      animation = _runLeftAnimation;
      if (position.x > 0) {
        position.add(Vector2(delta * -_playerSpeed, 0));
      }
    } else if (_playerDirection == PlayerDirection.right) {
      animation = _runRightAnimation;
      if (position.x < worldSize.x - size.x) {
        position.add(Vector2(delta * _playerSpeed, 0));
      }
    } else if (_playerDirection == PlayerDirection.none) {
      animation = _standingAnimation;
    }
  }

  Future<void> _loadAnimation() async {
    Image playerImage = await gameRef.images.load('player_spritesheet.png');
    final spriteSheet = SpriteSheet(
      image: playerImage,
      srcSize: Vector2(29, 32),
    );

    _runDownAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);

    _runLeftAnimation = spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);

    _runUpAnimation = spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);

    _runRightAnimation = spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    _standingAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);
  }
}
