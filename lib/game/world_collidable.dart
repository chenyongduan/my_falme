import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class WorldCollidable extends PositionComponent with Hitbox, Collidable {
  WorldCollidable() {
    addHitbox(HitboxRectangle());
  }
}
