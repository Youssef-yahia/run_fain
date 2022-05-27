import 'package:ourgame/gameObject.dart';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:ourgame/sprite.dart';

Sprite dodge = Sprite()
  ..imagePath = "assets/fain/fain.jpg"
  ..imageWidth = 88
  ..imageHeight = 94;

class Dodge extends GameObject {
  @override
  Widget render() {
    return Image.asset(dodge.imagePath);
  }

  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(screenSize.width / 10, screenSize.height / 2 - dodge.imageHeight, dodge.imageWidth.toDouble(), dodge.imageHeight.toDouble());
  }
}
