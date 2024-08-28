import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:game_project/circle_rotator.dart';
import 'package:game_project/color_switcher.dart';
import 'package:game_project/ground.dart';
import 'package:game_project/my_game.dart';
import 'package:game_project/star_component.dart';

class Player extends PositionComponent with HasGameRef<MyGame>, CollisionCallbacks{
  Player({
    required super.position,
    this.playerRadius = 12,
  });
  final Vector2 _velocity = Vector2(0, 0.0);
  final _gravity = 980.0;
  final _jumpSpeed = 350.0;

  final double playerRadius;

  Color _color = Colors.white;

  @override
  FutureOr<void> onLoad() {
    add(CircleHitbox(
      radius: playerRadius,
      anchor: anchor,
      collisionType: CollisionType.active,
    ));  
    return super.onLoad();
  }

  @override
  onMount() {
    size = Vector2.all(playerRadius * 2);
    anchor = Anchor.center;
    return super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _velocity * dt;

    Ground ground = gameRef.findByKeyName(Ground.keyName)!;

    if(positionOfAnchor(Anchor.bottomCenter).y > ground.position.y){
      _velocity.setZero();
      position.y = ground.position.y - height / 2;
    }else{
      _velocity.y += _gravity * dt;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(
      (size / 2).toOffset(),
      playerRadius,
      Paint()..color = _color,
    );
  }

  void jump() {
    _velocity.y = -_jumpSpeed;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ColorSwitcher){
      other.removeFromParent();
      _changeColorRandomly();
    }
    else if(other is CircleArc){
      if(_color != other.color){
        gameRef.gameOver();
      }
    }
    else if(other is StarComponent){
      other.removeFromParent();
      gameRef.increaseScore();
    }
  }
  
  void _changeColorRandomly() {
    _color = gameRef.gameColors.random();
  }
}
