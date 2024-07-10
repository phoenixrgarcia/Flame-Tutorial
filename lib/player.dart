import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent {
  Player({
    this.playerRadius = 15,
  });
  final Vector2 _velocity = Vector2(0, 0.0);
  final _gravity = 980.0;
  final _jumpSpeed = 350.0;

  final double playerRadius;

  @override
  FutureOr<void> onLoad() {
    position = Vector2.zero();
    size = Vector2.all(playerRadius * 2);
    anchor = Anchor.center;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _velocity * dt;
    _velocity.y += _gravity * dt;
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);

    canvas.drawCircle(
      (size / 2).toOffset(),
      playerRadius,
      Paint()..color = Colors.yellow,
    );
  }

  void jump() {
    _velocity.y = -_jumpSpeed;
  }
}
