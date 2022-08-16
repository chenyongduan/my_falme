import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:my_flame/constants/player.dart';
import 'package:my_flame/game/world_collidable.dart';

class Player extends SpriteAnimationComponent with HasGameRef, Hitbox, Collidable {
  final _playerSpeed = 300;
  final _animationSpeed = 0.15;
  bool _hasCollided = false;
  PlayerDirection _playerDirection = PlayerDirection.none;
  PlayerDirection _collisionDirection = PlayerDirection.none;

  late SpriteAnimation _runUpAnimation;
  late SpriteAnimation _runDownAnimation;
  late SpriteAnimation _runLeftAnimation;
  late SpriteAnimation _runRightAnimation;
  late SpriteAnimation _standingAnimation;

  Player() : super(size: Vector2.all(50.0)) {
    addHitbox(HitboxRectangle());
  }

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

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is WorldCollidable) {
      if (!_hasCollided) {
        _hasCollided = true;
        _collisionDirection = _playerDirection;
      }
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    _hasCollided = false;
  }

  setDirection(PlayerDirection direction) {
    _playerDirection = direction;
  }

  _checkCollided() {
    return _hasCollided && _collisionDirection == _playerDirection;
  }

  _movePlayer(double delta) {
    if (_playerDirection == PlayerDirection.up) {
      if (_checkCollided()) return;
      animation = _runUpAnimation;
      position.add(Vector2(0, delta * -_playerSpeed));
    } else if (_playerDirection == PlayerDirection.down) {
      if (_checkCollided()) return;
      animation = _runDownAnimation;
      position.add(Vector2(0, delta * _playerSpeed));
    } else if (_playerDirection == PlayerDirection.left) {
      if (_checkCollided()) return;
      animation = _runLeftAnimation;
      position.add(Vector2(delta * -_playerSpeed, 0));
    } else if (_playerDirection == PlayerDirection.right) {
      if (_checkCollided()) return;
      animation = _runRightAnimation;
      position.add(Vector2(delta * _playerSpeed, 0));
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
