import 'dart:ui';

import 'package:ourgame/roadBlock.dart';

import 'collider.dart';

class RoadBlock2 extends RoadBlock {
  @override
  Offset? worldLocation;

  RoadBlock2({this.worldLocation}) : super() {
    super.collider = Collider(Rect.fromLTWH(32, 64, 16, 16));
  }
}
