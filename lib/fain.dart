import 'package:ourgame/gameObject.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:ourgame/sprite.dart';

Sprite fain = Sprite()
  ..imagePath = "assets/fain/fain.jpg"
  ..imageWidth = 88
  ..imageHeight = 94;

class Fain extends GameObject {
  @override
  Widget render() {
    return Image.asset(fain.imagePath);
  }

  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(screenSize.width / 10, screenSize.height / 2 - fain.imageHeight, fain.imageWidth.toDouble(), fain.imageHeight.toDouble());
  }
}
