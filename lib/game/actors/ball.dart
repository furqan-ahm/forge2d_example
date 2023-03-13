import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/particles.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flameforge/game/utils/audioManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';

import '../components/bound.dart';

class Ball extends BodyComponent with Tappable, ContactCallbacks{
  
  Ball({required this.initialPos, required this.scoreFunc}):super(renderBody: false);

    bool firstFrame=true;
    Function scoreFunc;

    late StreamSubscription<AccelerometerEvent> sensorSubscription;
    late Uri hitSFX;
    int size=12;
    final Vector2 initialPos;
  
  @override
  Body createBody() {
    Shape shape = CircleShape()..radius=size/2;
    BodyDef bodyDef= BodyDef(position: initialPos, type: BodyType.dynamic, userData: this);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3, density: 1, restitution: 0.5);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }


  double sensorinput=0;

  @override
  void update(double dt) {
    if(firstFrame){
      gameRef.pauseEngine();
      firstFrame=false;
    }
    body.gravityOverride=Vector2(sensorinput.toDouble(),1)*150;
    final particleComponent=ParticleSystemComponent(
      particle: TranslatedParticle(child: CircleParticle(paint: Paint()..color=Colors.white, radius: 1, lifespan: 0.2), offset: body.linearVelocity.normalized()*-10)
    );
    if(body.linearVelocity.length>120)add(particleComponent);
    super.update(dt);
  }


  @override
  void onRemove() {
    //sensorSubscription.cancel();
    super.onRemove();
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Bound) {
      final double volume=body.linearVelocity.length;
      if(volume>20){
        AudioManager.playBounceSfx(1);
      }
      else if(volume>10){
        AudioManager.playBounceSfx(0.7);
      }
      else if(volume>5){
        AudioManager.playBounceSfx(0.4);
      }
    
    }
  }

    @override
  Future<void> onLoad() async{
    //hitSFX= await FlameAudio.audioCache.load('sfx/football.mp3');
    add(SpriteComponent()..sprite = await gameRef.loadSprite('ball.png')..size=Vector2.all(size.toDouble())..anchor=Anchor.center);
    await super.onLoad();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    double dx=body.position.x-info.eventPosition.game.x;
    scoreFunc();
    body.applyLinearImpulse(Vector2(dx*5000,-1*15500));
    AudioManager.playKickSfx(1);
    return super.onTapDown(info);
  }

  
  subscribe(){
    
    sensorSubscription = motionSensors.accelerometer.listen((event) {
      sensorinput=event.x/10 * -1;
    });
  }
}

