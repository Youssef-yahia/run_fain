import 'dart:ffi';

import 'package:ourgame/sprite.dart';

class Animation2D {
  List<Sprite> frames = [];

  Animation2D(String path, int start, int length, int width, int height) {
    for (int i = start; i <= length + start - 1; i++) {
      frames.add(Sprite()
        ..imagePath = "$path$i.png"
        ..imageWidth = width
        ..imageHeight = height);
    }
  }

  int length() => frames.length;

  double speed = 1;

  bool loop = false;

  Sprite getFrame(int milliseconds) {
    int frameIndex = (milliseconds / (100 / speed)).floor();
    return getFrameByIndex(frameIndex);
  }

  Sprite getFrameByIndex(int frameIndex) {
    if (loop) {
      frameIndex = frameIndex % length();
    } else {
      if (frameIndex >= length()) {
        frameIndex = length() - 1;
      }
    }
    return frames[frameIndex];
  }
}
