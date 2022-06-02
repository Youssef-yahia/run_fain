import 'package:flutter/material.dart';
import 'package:ourgame/collider.dart';
import 'package:ourgame/constants.dart';
import 'package:ourgame/game_object.dart';
import 'package:flutter/widgets.dart';
import 'package:ourgame/sprite.dart';
import 'package:ourgame/animation.dart';

enum FainState {
  jumping,
  running,
  dead,
}

class Fain extends GameObject {
  final int RUN = 0;
  final int JUMP = 1;
  final int DEAD = 2;

  List<Animation2D> animations = [];

  Sprite? currentSprite;
  double dispY = 0;
  double velY = 0;
  FainState state = FainState.running;
  Rect? _rect;

  Collider? collider;

  Duration? time = Duration();

  Fain() {
    animations.add(Animation2D("assets/meow2/run/run", 1, 4, 96, 96));
    animations.add(Animation2D("assets/meow2/jump/jump", 3, 7, 96, 96));
    animations.add(Animation2D("assets/meow2/die/die", 1, 5, 96, 96));

    animations[RUN].loop = true;
    animations[JUMP].loop = false;
    animations[DEAD].loop = false;
    animations[JUMP].speed = 0.75;

    currentSprite = animations[RUN].getFrame(0);

    collider = Collider(Rect.fromLTWH(32, 48, 32, 32));
  }

  @override
  Widget render() {
    return Stack(
      children: [
        collider!.render(),
        currentSprite!.image,
      ],
    );
    //Image.asset(currentSprite!.imagePath);
  }

  Rect getRect(Size screenSize, double runDistance) {
    _rect = Rect.fromLTWH(
        screenSize.width / 10,
        screenSize.height / 2 - currentSprite!.imageHeight - dispY,
        currentSprite!.imageWidth.toDouble(),
        currentSprite!.imageHeight.toDouble());
    return _rect!;
  }

  @override
  void update(Duration delta, Duration currentTime) {
    time = time! + delta;

    updateCollider();
    updateAnimations();

    double deltaSeconds = delta.inMilliseconds / 1000;
    dispY += velY * deltaSeconds;
    if (dispY <= 0) {
      dispY = 0;
      velY = 0;
      if (state != FainState.dead) {
        if (state != FainState.running) {
          state = FainState.running;
          print("GO TO IDLE");
        }
      }
    } else {
      velY -= GRAVITY_PPSS * deltaSeconds;
    }
  }

  void updateCollider() {
    switch (state) {
      case FainState.dead:
        collider!.setRect(Rect.fromLTRB(0, 0, 0, 0));
        break;
      default:
        collider = Collider(Rect.fromLTWH(32, 48, 32, 32));
        break;
    }
  }

  void updateAnimations() {
    int currentAnimation = 0;

    switch (state) {
      case FainState.running:
        currentAnimation = RUN;
        break;
      case FainState.jumping:
        currentAnimation = JUMP;
        break;
      case FainState.dead:
        currentAnimation = DEAD;
        break;
    }

    currentSprite = animations[currentAnimation].getFrame(time!.inMilliseconds);
  }

  void jump() {
    if (state == FainState.dead) return;
    if (state != FainState.jumping) {
      state = FainState.jumping;
      print("GO TO JUMP");

      velY = 600;
      time = Duration();
    }
  }

  void die() {
    if (state != FainState.dead) {
      state = FainState.dead;
      print("DEAD");
      time = Duration();
    }
  }
}
