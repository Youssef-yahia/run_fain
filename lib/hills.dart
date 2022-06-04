import 'package:flutter/material.dart';
import 'package:ourgame/constants.dart';
import 'package:ourgame/game_object.dart';
import 'package:flutter/widgets.dart';
import 'package:ourgame/animation.dart';
import 'package:ourgame/sprite.dart';
import "dart:math";

class Hills extends GameObject {
  final int ROADBLOCK = 0;

  bool skipImg = false;

  Sprite? sprite;
  Offset? worldLocation;
  Rect? _rect;

  Hills({this.worldLocation}) {
    sprite = Sprite("assets/hills.png");
    sprite!.setSize(1278, 1152);
  }

  @override
  Rect getRect(Size screenSize, double runDistance) {
    _rect = Rect.fromLTWH(
      (worldLocation!.dx - runDistance * 0.1) * WORLD_TO_PIXEL_RATIO,
      -screenSize.height * 0.3,
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
