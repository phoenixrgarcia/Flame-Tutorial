import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:game_project/ground.dart';
import 'package:game_project/player.dart';
import 'package:flame/game.dart';

class MyGame extends FlameGame with TapCallbacks {
  late Player myPlayer;

  MyGame()
      : super(
            camera: CameraComponent.withFixedResolution(
          width: 600,
          height: 1000,
        ));

  @override
  Color backgroundColor() => const Color(0xff222222);

  @override
  void onMount() {
    world.add(Ground(position: Vector2(0,400)));
    world.add(myPlayer = Player());
    super.onMount();
  }

  @override
  void onTapDown(TapDownEvent event) {
    myPlayer.jump();
    super.onTapDown(event);
  }

  @override
  void update(double dt) {
    
    
    if(myPlayer.position.y < camera.viewfinder.position.y){
      camera.viewfinder.position = myPlayer.position ;
    }
    super.update(dt);
  }
}
