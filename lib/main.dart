import 'dart:async';

import 'package:flame/game.dart';
import 'package:flameforge/game/soccerGame.dart';
import 'package:flameforge/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}


final SoccerGame game=SoccerGame();


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //SvgPicture.network('https://avatars.dicebear.com/api/male/john.svg');
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen()
    );
  }
}
