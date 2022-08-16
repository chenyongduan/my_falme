import 'dart:convert';
import 'package:flutter/services.dart';

class MapLoader {
  static Future<List<Rect>> readCollisionMap() async {
    final collisionList = <Rect>[];
    final dynamic collisionMap = json.decode(
      await rootBundle.loadString('assets/rayworld_collision_map.json'),
    );

    for (final dynamic data in collisionMap['objects']) {
      collisionList.add(Rect.fromLTWH(
        data['x'],
        data['y'],
        data['width'],
        data['height'],
      ));
    }
    return collisionList;
  }
}
