import 'package:ourgame/constants.dart';
import 'package:ourgame/game_object.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:ourgame/sprite.dart';

enum FainState {
  jumping,
  running,
}

class Fain extends GameObject {
  Fain() {
    for (int i = 1; i <= 8; i++) {
      fainRunning.add(Sprite()
        ..imagePath = "assets/meow/run/meow$i.png"
        ..imageWidth = 96
        ..imageHeight = 96);
    }
    for (int i = 1; i <= 12; i++) {
      fainJumping.add(Sprite()
        ..imagePath = "assets/meow/jump/meow$i.png"
        ..imageWidth = 96
        ..imageHeight = 96);
    }

    currentSprite = fainRunning[0];
  }

  List<Sprite> fainRunning = [];
  List<Sprite> fainJumping = [];
  Sprite? currentSprite;
  double dispY = 0;
  double velY = 0;
  FainState state = FainState.running;

  @override
  Widget render() {
    return Image.asset(currentSprite!.imagePath);
  }

  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(screenSize.width / 10, screenSize.height / 2 - currentSprite!.imageHeight - dispY, currentSprite!.imageWidth.toDouble(), currentSprite!.imageHeight.toDouble());
  }

  @override
  void update(Duration lastTime, Duration currentTime) {
    if (state == FainState.running) {
      currentSprite = fainRunning[(currentTime.inMilliseconds / 100).floor() % 8];
    }
    if (state == FainState.jumping) {
      currentSprite = fainJumping[(currentTime.inMilliseconds / 100).floor() % 12];
    }

    double elapsedTimeSeconds = (currentTime - lastTime).inMilliseconds / 1000;
    dispY += velY * elapsedTimeSeconds;
    if (dispY <= 0) {
      dispY = 0;
      velY = 0;
      state = FainState.running;
    } else {
      velY -= GRAVITY_PPSS * elapsedTimeSeconds;
    }
  }

  void jump() {
    if (state != FainState.jumping) {
      state = FainState.jumping;
      velY = 650;
    }
  }
}
