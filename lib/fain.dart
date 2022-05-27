import 'package:ourgame/game_object.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:ourgame/sprite.dart';

class Fain extends GameObject {
  Fain() {
    for (int i = 1; i <= 8; i++) {
      fains.add(Sprite()
        ..imagePath = "assets/meow/dodge/meow$i.png"
        ..imageWidth = 96
        ..imageHeight = 96);
    }
    currentSprite = fains[0];
  }

  List<Sprite> fains = [];
  Sprite? currentSprite;

  @override
  Widget render() {
    return Image.asset(currentSprite!.imagePath);
  }

  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(screenSize.width / 10, screenSize.height / 2 - currentSprite!.imageHeight, currentSprite!.imageWidth.toDouble(), currentSprite!.imageHeight.toDouble());
  }

  @override
  void update(Duration lastTime, Duration currentTime) {
    currentSprite = fains[(currentTime.inMilliseconds / 100).floor() % 8];
  }
}
