import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_project/my_game.dart';

class ColorSwitcher extends PositionComponent with HasGameRef<MyGame>, CollisionCallbacks{
  ColorSwitcher({
    required super.position,
    this.radius = 20,
  }) : super(anchor: Anchor.center, size: Vector2.all(radius * 2));
  
  final double radius; 

  @override
  FutureOr<void> onLoad() {
    add(CircleHitbox(
      position: size / 2,
      radius: radius,
      anchor: anchor,
      collisionType: CollisionType.passive,
    ));
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    final length = gameRef.gameColors.length;
    final sweepAngle = (pi * 2) / length;
    for (int i = 0; i < length; i++){
      canvas.drawArc(
        size.toRect(),
        i * sweepAngle ,
        sweepAngle,
        true,
        Paint()..color = gameRef.gameColors[i],
      );
  }

    }
}