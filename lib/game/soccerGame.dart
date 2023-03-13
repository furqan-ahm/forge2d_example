import 'dart:async';

import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flameforge/game/actors/ball.dart';
import 'package:flameforge/game/components/bound.dart';
import 'package:flameforge/game/hud/hud.dart';
import 'package:flameforge/game/utils/audioManager.dart';
import 'package:flutter/cupertino.dart';




class SoccerGame extends Forge2DGame with HasTappables, HasCollisionDetection{
  
  late Ball ball;
  late Vector2 gameSize;
  final globalScore = ValueNotifier<int>(0);
  int maxScore=0;

  @override
  Color backgroundColor()=>const Color.fromARGB(255, 14, 14, 39);

  scoreFunc(){
    
    globalScore.value++;
  }

  @override
  Future<void>? onLoad() async{
    gameSize = screenToWorld(camera.viewport.effectiveSize);
    add(Hud());
    AudioManager.init();
    ball=Ball(initialPos: gameSize/2,scoreFunc: scoreFunc);
    //add(SpriteComponent()..sprite = await loadSprite('background.webp')..size = size);
    add(ball);
    add(Bound(p1: Vector2(0,-gameSize.y),p2: Vector2(0,gameSize.y)));
    //add(Bound(p1: Vector2(0,gameSize.y),p2: Vector2(gameSize.x,gameSize.y)));
    add(Bound(p1: Vector2(gameSize.x,-gameSize.y),p2: Vector2(gameSize.x,gameSize.y)));
    await super.onLoad();
  }

  @override
  void update(double dt) {
    if(ball.isLoaded){
      if(ball.body.position.y>gameSize.y+50){
        ball.body.setTransform(Vector2(gameSize.x/2,gameSize.y/2), 0);
        ball.body.linearVelocity=Vector2.zero();
        ball.body.angularVelocity=0;
        if(globalScore.value>maxScore){
          maxScore=globalScore.value;
        }
        else{
          globalScore.value=maxScore;
        }
        pauseEngine();
      }
    }
    super.update(dt);
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    if(paused) {
      resumeEngine();
      globalScore.value=0;
    }
    super.onTapDown(pointerId, info);
  }

}