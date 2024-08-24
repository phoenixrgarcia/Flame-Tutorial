import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';
import 'package:game_project/circle_rotator.dart';
import 'package:game_project/color_switcher.dart';
import 'package:game_project/ground.dart';
import 'package:game_project/player.dart';
import 'package:flame/game.dart';

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection, HasDecorator, HasTimeScale {
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
  FutureOr<void> onLoad() {
    decorator = new PaintDecorator.blur(0);
    return super.onLoad();
  }

  @override
  void onMount() {
    _initializeGame();
    //debugMode = true;
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
  
  void _initializeGame() {
    world.add(Ground(position: Vector2(0,400)));
    world.add(myPlayer = Player(position: Vector2(0, 250)));
    camera.moveTo(Vector2(0,0));
    _generateGameComponents();
  }

  void _generateGameComponents() {
    world.add(ColorSwitcher(position: Vector2(0, 180)));
    world.add(ColorSwitcher(position: Vector2(0, 20)));
    world.add(CircleRotator(
      position: Vector2(0,0),
      size: Vector2(200, 200),
    ));
  }

  void gameOver(){
    for (var element in world.children) {
      element.removeFromParent();
    }
      _initializeGame();
  }

  bool get isGamePaused => timeScale == 0.0;

  bool get isGamePlaying => !isGamePaused;

  void pauseGame() {
    (decorator as PaintDecorator).addBlur(10);
    timeScale = 0.0;
    //pauseEngine();
  }

  void resumeGame() {
    (decorator as PaintDecorator).addBlur(0);
    timeScale = 1.0;
    //resumeEngine();
  }
  
}
