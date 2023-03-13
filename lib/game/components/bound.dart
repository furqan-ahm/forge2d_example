import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

import '../actors/ball.dart';

class Bound extends BodyComponent with ContactCallbacks{
  final Vector2 p1,p2;


  Bound({required this.p1,required this.p2}):super(renderBody: false);
  
  @override
  Body createBody() {
    //Shape shape = EdgeShape()..set(p1,p2);
    Shape shape = PolygonShape()..set([p1,Vector2(p1.x+2,p1.y+2),Vector2(p2.x+2,p2.y+2),p2]);
    final bodyDef = BodyDef(userData: this, position: Vector2(0,0), type: BodyType.dynamic);
    final fixtureDef = FixtureDef(shape,friction: 0.5);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }


  
  @override
  void beginContact(Object other, Contact contact) {
    if (other is Ball) {
      final particleComponent=ParticleSystemComponent(
      particle: CircleParticle(paint: Paint()..color=Colors.white, radius: 1, lifespan: 0.01)
      );
      add(particleComponent);
    }  
  }

}