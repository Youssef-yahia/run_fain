import 'package:flutter/material.dart';

class NonePageRoute extends MaterialPageRoute {
  NonePageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}
