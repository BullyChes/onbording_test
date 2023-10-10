import 'package:flutter/material.dart';

class BaseColors {
  // base colors
  static const transparent = Color(0x00000000);
  static const white = Color(0xffffffff);
  static const black = Color(0xff000000);

  // OnBoarding colors
  static const blue = Color(0xff99d2ff);
  static const orange = Color(0xffff9b04);
  static const red = Color(0xfff85153);
  static const darkGrey = Color(0xff19191b);
  static const greenGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff67e99a),
      Color(0xff44cd6e),
      Color(0xff4ad276),
    ],
  );

  // indicator colors
  static const indicator100 = Color(0xfff6f7f8);
  static const indicator20 = Color(0x33f6f7f8);
}
