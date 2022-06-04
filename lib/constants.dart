import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ourgame/tile.dart';

const int GRAVITY_PPSS = 2000;
const int WORLD_TO_PIXEL_RATIO = 10;

const TextStyle STYLE_REGULAR = TextStyle(
  color: Colors.white,
  fontFamily: "Arcade",
  decoration: TextDecoration.none,
  fontSize: 32,
);
const TextStyle STYLE_REGULAR2 = TextStyle(
  color: Colors.white,
  fontFamily: "Arcade",
  decoration: TextDecoration.none,
  fontSize: 48,
);
const TextStyle STYLE_TITLE = TextStyle(
  color: Colors.white,
  fontFamily: "Title",
  decoration: TextDecoration.none,
  fontSize: 28,
);

List<int> SCORES = [];
