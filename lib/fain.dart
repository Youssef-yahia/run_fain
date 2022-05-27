import 'package:ourgame/gameObject.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:ourgame/sprite.dart';

List<Sprite> fain = [
  Sprite()
    ..imagePath = "assets/fain/fain.jpg"
    ..imageWidth = 200
    ..imageHeight = 207,
  Sprite()
    ..imagePath = "assets/fain/fain.jpg"
    ..imageWidth = 200
    ..imageHeight = 207,
  Sprite()
    ..imagePath = "assets/fain/fain.jpg"
    ..imageWidth = 200
    ..imageHeight = 207,
  Sprite()
    ..imagePath = "assets/fain/fain.jpg"
    ..imageWidth = 200
    ..imageHeight = 207,
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
    currentSprite = fain[(currentTime.inMilliseconds / 100).floor() % 2 + 2];
  }
}
