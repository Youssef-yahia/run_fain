import 'package:flutter/material.dart';
import 'package:ourgame/constants.dart';
import 'package:ourgame/game_object.dart';
import 'package:flutter/widgets.dart';
import 'package:ourgame/animation.dart';
import 'package:ourgame/sprite.dart';
import "dart:math";

class Skybox extends GameObject {
  final int ROADBLOCK = 0;

  bool skipImg = false;

  Sprite? sprite;
  Offset? worldLocation;
  Rect? _rect;

  Skybox({this.worldLocation}) {
    sprite = Sprite("assets/BG.png");
    sprite!.setSize(480, 480);
  }

  @override
  Rect getRect(Size screenSize, double runDistance) {
    _rect = Rect.fromLTWH(
      (worldLocation!.dx - runDistance * 0.02) * WORLD_TO_PIXEL_RATIO,
      0,
      sprite!.imageWidth.toDouble(),
      sprite!.imageHeight.toDouble(),
    );
    return _rect!;
  }

  @override
  Widget render() {
    return sprite!.image;

    //Image.asset(currentSprite!.imagePath);
  }
}
