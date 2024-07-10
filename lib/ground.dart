

import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ground extends PositionComponent{
  static const String keyName = 'ground_key';

  Ground({required super.position})
      : super(
          size: Vector2(100, 1),
          anchor: Anchor.center,
          key: ComponentKey.named(keyName),
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      const Rect.fromLTWH(0, 0, 100, 1),
      Paint()..color = Colors.red,
    );
  }

}