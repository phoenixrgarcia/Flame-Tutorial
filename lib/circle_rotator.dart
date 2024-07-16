import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:game_project/my_game.dart';

class CircleRotator extends PositionComponent with HasGameRef<MyGame> {
  CircleRotator({
    required super.position,
    required super.size,
    this.thickness = 8.0,
    this.rotationSpeed = 2,
  })  : assert(size!.x == size.y),
        super(
          anchor: Anchor.center,
        );

  final double thickness;
  final double rotationSpeed;

  @override
  void onLoad() {
    super.onLoad();

    const twoPi = pi * 2;
    final sweep = twoPi / gameRef.gameColors.length;
    for (int i = 0; i < gameRef.gameColors.length; i++) {
      add(CircleArc(
        color: gameRef.gameColors[i],
        startAngle: sweep * i,
        sweepAngle: sweep,
      ));
    }

    add(RotateEffect.to(
        pi * 2,
        EffectController(
          speed: rotationSpeed,
          infinite: true,
        )));
  }

}

class CircleArc extends PositionComponent with ParentIsA<CircleRotator> {
  final Color color;
  final double startAngle;
  final double sweepAngle;

  CircleArc({
    required this.color,
    required this.startAngle,
    required this.sweepAngle,
  }) : super(anchor: Anchor.center);

  @override
  void onMount() {
    size = parent.size;
    position = size / 2;
    super.onMount();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawArc(
      size.toRect().deflate(parent.thickness / 2),
      startAngle,
      sweepAngle,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = parent.thickness,
    );
    super.render(canvas);
  }
}
