import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:game_project/circle_rotator.dart';
import 'package:game_project/ground.dart';
import 'package:game_project/player.dart';
import 'package:flame/game.dart';

class MyGame extends FlameGame with TapCallbacks {
  late Player myPlayer;

  final List<Color> gameColors;

  MyGame({this.gameColors = const [
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.yellowAccent,
  ]})
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
    world.add(myPlayer = Player(position: Vector2(0, 250)));

    generateGameComponents();
    // debugMode = true;
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
  
  void generateGameComponents() {
    world.add(CircleRotator(
      position: Vector2(0,-100),
      size: Vector2(200, 200),
    ));
  }
}
