
import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';

class StarComponent extends PositionComponent with CollisionCallbacks{
  late Sprite _starSprite;

  StarComponent({
    required super.position}) 
    : super(
      anchor: Anchor.center,
      size: Vector2(28, 28),
      );

  @override
  FutureOr<void> onLoad() async{
    await super.onLoad();
    _starSprite = await Sprite.load('starIcon.png');
    decorator.addLast(PaintDecorator.tint(Colors.white));

    add(CircleHitbox(radius: size.x / 2, collisionType: CollisionType.passive));

  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _starSprite.render(canvas, position: size / 2, size:size, anchor: Anchor.center);
  }


}