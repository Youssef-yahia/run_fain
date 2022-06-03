import 'package:flutter/material.dart';
import 'package:ourgame/constants.dart';
import 'package:ourgame/game_object.dart';
import 'package:flutter/widgets.dart';
import 'package:ourgame/animation.dart';
import 'package:ourgame/sprite.dart';
import "dart:math";

import 'collider.dart';

class RoadBlock extends GameObject {
  final int ROADBLOCK = 0;

  List<Animation2D> animation = [];

  Sprite? sprite;
  Offset? worldLocation;
  Rect? _rect;

  Collider? collider;

  RoadBlock({this.worldLocation}) {
    animation.add(Animation2D("assets/tiles/spikes", 1, 1, 48, 48));
    sprite = animation[ROADBLOCK].getFrame(Random().nextInt(animation.length));

    collider = Collider(Rect.fromLTWH(0, 0, 48, 48));
  }

  @override
  Rect getRect(Size screenSize, double runDistance) {
    _rect = Rect.fromLTWH(
      (worldLocation!.dx - runDistance) * WORLD_TO_PIXEL_RATIO,
      screenSize.height / 2 - sprite!.imageHeight,
      sprite!.imageWidth.toDouble(),
      sprite!.imageHeight.toDouble(),
    );
    return _rect!;
  }

  @override
  Widget render() {
    return Stack(
      children: [
        //collider!.render(),
        Image.asset(sprite!.imagePath),
      ],
    );
    //Image.asset(currentSprite!.imagePath);
  }
}
