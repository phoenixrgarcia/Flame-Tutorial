
import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
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

    add(CircleHitbox(radius: size.x / 2, collisionType: CollisionType.passive));

  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _starSprite.render(canvas, position: size / 2, size:size, anchor: Anchor.center);
  }

  void showCollectEffect() {
    final rnd = Random();
    Vector2 randomVector2() => (Vector2.random(rnd) - Vector2.random(rnd)) * 100;
    parent!.add(
      ParticleSystemComponent(
        position: position,
        particle: Particle.generate(
          lifespan: 1.0,
          count: 30,
          generator: (i) {
                return AcceleratedParticle(
                    speed: randomVector2(),
                    acceleration: randomVector2(),
                    child: RotatingParticle(
                      to: rnd.nextDouble() * 2 * pi,
                      child: ComputedParticle(renderer: (canvas, particle) {
                        _starSprite.render(canvas,
                            size: size * (1 - particle.progress),
                            anchor: Anchor.center,
                            overridePaint: Paint()
                              ..color = Colors.white
                                  .withOpacity(1 - particle.progress));
                      }),
                    ));
              })),
    );

    removeFromParent();
  }


}