import 'package:flutter/material.dart';
import 'package:ourgame/constants.dart';
import 'package:ourgame/game_object.dart';
import 'package:flutter/widgets.dart';
import 'package:ourgame/animation.dart';
import 'package:ourgame/sprite.dart';
import "dart:math";

enum TileType { Surface, Deep, Grass }

class Tile extends GameObject {
  final int ROADBLOCK = 0;

  bool skipImg = false;

  Sprite? sprite;
  Offset? worldLocation;
  Offset? absoluteLocation;
  Rect? _rect;

  TileType? tileType;

  Tile({this.absoluteLocation, this.tileType}) {
    worldLocation = Offset(0, 0);
    refresh();
  }

  void refresh() {
    String name = "";
    int random = 1;
    skipImg = false;
    switch (tileType) {
      case TileType.Surface:
        name = "surface";
        break;

      case TileType.Grass:
        name = "grass";
        int rndSkip = Random().nextInt(10);
        if (rndSkip >= 1) {
          skipImg = true;
        }
        break;

      case TileType.Deep:
        name = "deep";
        random = 2;
        break;
    }
    if (!skipImg) {
      if (random > 1) {
        int rndIndex = Random().nextInt(random) + 1;
        name += rndIndex.toString();
      }
      String imgPath = "assets/tiles/" + name + ".png";

      sprite = Sprite(imgPath);
      sprite!.setSize(48, 48);
    } else {
      sprite = Sprite("assets/empty.png");
      sprite!.setSize(48, 48);
    }
  }

  @override
  Rect getRect(Size screenSize, double runDistance) {
    _rect = Rect.fromLTWH(
      (worldLocation!.dx - runDistance) * WORLD_TO_PIXEL_RATIO +
          absoluteLocation!.dx * sprite!.imageWidth,
      screenSize.height / 2 -
          sprite!.imageHeight +
          absoluteLocation!.dy * sprite!.imageHeight,
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
