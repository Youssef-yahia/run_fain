import 'package:ourgame/game_object.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:ourgame/sprite.dart';

List<Sprite> fain = [
  Sprite()
    ..imagePath = "assets/meow/run/meow1.png"
    ..imageWidth = 96
    ..imageHeight = 96,
  Sprite()
    ..imagePath = "assets/meow/run/meow2.png"
    ..imageWidth = 96
    ..imageHeight = 96,
  Sprite()
    ..imagePath = "assets/meow/run/meow3.png"
    ..imageWidth = 96
    ..imageHeight = 96,
  Sprite()
    ..imagePath = "assets/meow/run/meow4.png"
    ..imageWidth = 96
    ..imageHeight = 96,
  Sprite()
    ..imagePath = "assets/meow/run/meow5.png"
    ..imageWidth = 96
    ..imageHeight = 96,
  Sprite()
    ..imagePath = "assets/meow/run/meow6.png"
    ..imageWidth = 96
    ..imageHeight = 96,
  Sprite()
    ..imagePath = "assets/meow/run/meow7.png"
    ..imageWidth = 96
    ..imageHeight = 96,
  Sprite()
    ..imagePath = "assets/meow/run/meow8.png"
    ..imageWidth = 96
    ..imageHeight = 96,
];

class Fain extends GameObject {
  Sprite currentSprite = fain[0];
  @override
  Widget render() {
    return Image.asset(currentSprite.imagePath);
  }

  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(screenSize.width / 10, screenSize.height / 2 - currentSprite.imageHeight, currentSprite.imageWidth.toDouble(), currentSprite.imageHeight.toDouble());
  }

  @override
  void update(Duration lastTime, Duration currentTime) {
    currentSprite = fain[(currentTime.inMilliseconds / 100).floor() % 7 + 7];
  }
}
