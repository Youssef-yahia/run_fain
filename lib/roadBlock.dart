import 'package:ourgame/constants.dart';
import 'package:ourgame/game_object.dart';
import 'package:flutter/widgets.dart';
import 'package:ourgame/animation.dart';
import 'package:ourgame/sprite.dart';
import "dart:math";

class RoadBlock extends GameObject {
  final int RUN = 0;

  List<Animation2D> animation = [];

  Sprite? sprite;
  Offset? worldLocation;

  RoadBlock({this.worldLocation}) {
    animation.add(Animation2D("assets/meow2/run/run", 1, 4, 96, 96));
    sprite = animation[RUN].getFrame(Random().nextInt(animation.length));
  }

  @override
  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(
      (worldLocation!.dx - runDistance) * WORLD_TO_PIXEL_RATIO,
      screenSize.height / 2 - sprite!.imageHeight,
      sprite!.imageWidth.toDouble(),
      sprite!.imageHeight.toDouble(),
    );
  }

  @override
  Widget render() {
    return Image.asset(sprite!.imagePath);
  }
}
