import 'package:flutter/widgets.dart';

class Sprite {
  String imagePath = '';
  int imageWidth = 0;
  int imageHeight = 0;
  late Image image;

  Sprite(String path) {
    imagePath = path;
    image = Image.asset(imagePath);
  }

  void setSize(int width, int height) {
    imageWidth = width;
    imageHeight = height;
  }
}
