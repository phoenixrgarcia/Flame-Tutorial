import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
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

class CircleArc extends PositionComponent with ParentIsA<CircleRotator>, CollisionCallbacks {
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

    _addHitBox();
    
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
  
  void _addHitBox() {
    final center = size / 2;
    final radius = size.x / 2;

    final precision = 6;

    final segment = sweepAngle / (precision - 1) ;

    List<Vector2> vertices = [];
    for(int i = 0; i < precision; i++){
      final thisSegment = segment * i;
      vertices.add(center + Vector2(cos(thisSegment + startAngle), sin(thisSegment + startAngle)) * radius);

    }

    for(int i = precision - 1; i >= 0; i--){
      final thisSegment = segment * i;
      vertices.add(center + Vector2(cos(thisSegment + startAngle), sin(thisSegment + startAngle)) * (radius - parent.thickness));

    }

    add(PolygonHitbox(vertices, collisionType: CollisionType.passive));
  }
}
