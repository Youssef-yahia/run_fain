import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class SoundPlayer {
  final String PATH_SOUND_BGM = "sounds/BGM.mp3";
  final String PATH_SOUND_JUMP = "sounds/jump.mp3";
  final String PATH_SOUND_DIE = "sounds/hit.mp3";

  static SoundPlayer? _instance;

  AudioPlayer _bgmPlayer = AudioPlayer();
  AudioCache _sfxJump = AudioCache();
  AudioCache _sfxDie = AudioCache();

  static SoundPlayer getInstance() {
    if (_instance == null) {
      _instance = SoundPlayer();
    }
    return _instance!;
  }

  SoundPlayer() {}

  void playBGM() async {
    if (_bgmPlayer.state == PlayerState.PLAYING) return;
    AudioCache player = new AudioCache(fixedPlayer: _bgmPlayer);
    player.loop(PATH_SOUND_BGM);
  }

  void stopBGM() async {
    _bgmPlayer.stop();
  }

  void playJump() async {
    _sfxJump.play(PATH_SOUND_JUMP);
  }

  void playDie() async {
    _sfxDie.play(PATH_SOUND_DIE);
  }
}
