import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_flame/constants/player.dart';

class JoyPad extends StatefulWidget {
  final ValueChanged<PlayerDirection>? onDirectionChange;

  const JoyPad({Key? key, this.onDirectionChange}) : super(key: key);

  @override
  State<JoyPad> createState() => _JoypadState();
}

class _JoypadState extends State<JoyPad> {
  Offset delta = Offset.zero;
  static const double size = 60;

  onDragDown(DragDownDetails e) {
    onDealDelta(e.localPosition);
  }

  onDragUpdate(DragUpdateDetails e) {
    onDealDelta(e.localPosition);
  }

  onDragEnd(DragEndDetails e) {
    widget.onDirectionChange!(PlayerDirection.none);
    setState(() {
      delta = Offset.zero;
    });
  }

  PlayerDirection getDirectionByOffset(Offset offset) {
    PlayerDirection direction = PlayerDirection.none;
    if (offset.dx < -20) {
      direction = PlayerDirection.left;
    } else if (offset.dx > 20) {
      direction = PlayerDirection.right;
    } else if (offset.dy < -20) {
      direction = PlayerDirection.up;
    } else if (offset.dy > 20) {
      direction = PlayerDirection.down;
    }
    return direction;
  }

  onDealDelta(Offset offset) {
    final localPosition = offset - const Offset(size, size);
    setState(() {
      delta = Offset.fromDirection(
        localPosition.direction,
        min(size / 2, localPosition.distance),
      );
    });
    widget.onDirectionChange!(getDirectionByOffset(localPosition));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: onDragDown,
      onPanUpdate: onDragUpdate,
      onPanEnd: onDragEnd,
      child: Container(
        width: size * 2,
        height: size * 2,
        decoration: BoxDecoration(
          color: const Color(0x88ffffff),
          borderRadius: BorderRadius.circular(size),
        ),
        child: Center(
          child: Transform.translate(
            offset: delta,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xccffffff),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
