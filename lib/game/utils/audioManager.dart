import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioManager {
  static final sfx = ValueNotifier(true);
  static final bgm = ValueNotifier(true);
  static AudioPlayer audioPlayer = AudioPlayer();
  static AudioCache cache = AudioCache();
  
  
  static Future<void> init() async {
    
    await cache.loadAll(['audio/effec1.mp3','audio/effect2.mp3']);
    // audioPlayer.onPositionChanged.listen((event) {print(event.inMilliseconds);});
    // await audioPlayer.setSourceAsset('audio/football.mp3');  
    // await audioPlayer.setPlayerMode(PlayerMode.lowLatency);
  }

  static void playKickSfx(double? volume) {
    if (sfx.value) {
      cache.play('audio/effect1.mp3',volume: volume??1);
    }
  }

  static void playBounceSfx(double? volume){
    cache.play('audio/effect2.mp3',volume: volume??1);
  }



}