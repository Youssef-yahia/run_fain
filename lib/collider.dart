import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Collider {
  Rect? _colliderRect;

  Collider(Rect rect) {
    _colliderRect = rect;
  }

  Widget render() {
    return Positioned(
        child: SizedBox(
            width: _colliderRect!.width,
            height: _colliderRect!.height,
            child: const DecoratedBox(
              decoration: const BoxDecoration(color: Colors.red),
            )),
        top: _colliderRect!.top,
        left: _colliderRect!.left);
  }

  Rect getRect(Rect objRect) {
    Rect rect = objRect;
    return Rect.fromLTWH(
        rect.left + _colliderRect!.left,
        rect.top + _colliderRect!.top,
        _colliderRect!.width,
        _colliderRect!.height);
  }

  void setRect(Rect rect) {
    _colliderRect = rect;
  }
}
