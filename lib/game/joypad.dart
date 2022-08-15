import 'package:flutter/material.dart';

class JoyPad extends StatefulWidget {
  const JoyPad({Key? key}) : super(key: key);

  @override
  State<JoyPad> createState() => _JoypadState();
}

class _JoypadState extends State<JoyPad> {
  Offset delta = Offset.zero;

  onDragDown(DragDownDetails e) {
    var localPosition = e.localPosition - const Offset(60, 60);
    print('onDragDown=$localPosition');
  }

  onDragUpdate(DragUpdateDetails e) {
    var localPosition = e.localPosition - const Offset(60, 60);
    print('onDragUpdate=$localPosition');
  }

  onDragEnd(DragEndDetails e) {
    print('onDragEnd=$e');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: onDragDown,
      onPanUpdate: onDragUpdate,
      onPanEnd: onDragEnd,
      child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0x88ffffff),
            borderRadius: BorderRadius.circular(60),
          ),
          child: Center(
              child: Transform.translate(
                  offset: Offset.fromDirection(100),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xccffffff),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  )))),
    );
  }
}
