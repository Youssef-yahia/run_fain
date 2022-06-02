import 'package:ourgame/constants.dart';
import 'package:ourgame/game_object.dart';
import 'package:flutter/widgets.dart';
import 'package:ourgame/sprite.dart';
import 'package:ourgame/animation.dart';

enum FainState {
  jumping,
  running,
}

class Fain extends GameObject {
  final int RUN = 0;
  final int JUMP = 1;

  List<Animation2D> animations = [];

  Sprite? currentSprite;
  double dispY = 0;
  double velY = 0;
  FainState state = FainState.running;

  Duration? time = Duration();

  Fain() {
    animations.add(Animation2D("assets/meow2/run/run", 1, 4, 96, 96));
    animations.add(Animation2D("assets/meow2/jump/jump", 3, 7, 96, 96));

    animations[RUN].loop = true;
    animations[JUMP].loop = false;
    animations[JUMP].speed = 0.75;

    currentSprite = animations[RUN].getFrame(0);
  }

  @override
  Widget render() {
    return Image.asset(currentSprite!.imagePath);
  }

  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(screenSize.width / 10, screenSize.height / 2 - currentSprite!.imageHeight - dispY, currentSprite!.imageWidth.toDouble(), currentSprite!.imageHeight.toDouble());
  }

  @override
  void update(Duration delta, Duration currentTime) {
    time = time! + delta;

    updateAnimations();

    double deltaSeconds = delta.inMilliseconds / 1000;
    dispY += velY * deltaSeconds;
    if (dispY <= 0) {
      dispY = 0;
      velY = 0;
      if (state != FainState.running) {
        state = FainState.running;
        print("GO TO IDLE");
      }
    } else {
      velY -= GRAVITY_PPSS * deltaSeconds;
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
    }

    currentSprite = animations[currentAnimation].getFrame(time!.inMilliseconds);
  }

  void jump() {
    if (state != FainState.jumping) {
      state = FainState.jumping;
      print("GO TO JUMP");

      velY = 600;
      time = Duration();
    }
  }
}
