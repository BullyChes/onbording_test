import 'package:flutter/material.dart';
import 'package:flutter_onboarding/UI/Style/base_colors.dart';

class TextStyles {
  static const bodyText = BaseTextStyle.regular(
    fontSize: 19,
    lineHeight: 28,
    letterSpacing: -0.01,
  );

  static const headline = BaseTextStyle.black(
    fontSize: 28,
    lineHeight: 40,
    letterSpacing: -0.01,
  );
}

class BaseTextStyle extends TextStyle {
  const BaseTextStyle._({
    required double super.fontSize,
    required double lineHeight,
    required FontWeight super.fontWeight,
    super.letterSpacing,
  }) : super(
          height: lineHeight / fontSize,
          color: BaseColors.white,
        );

  const BaseTextStyle.regular({
    required double fontSize,
    required double lineHeight,
    double? letterSpacing,
  }) : this._(
          fontSize: fontSize,
          lineHeight: lineHeight,
          letterSpacing: letterSpacing,
          fontWeight: FontWeight.w400,
        );

  const BaseTextStyle.medium({
    required double fontSize,
    required double lineHeight,
    double? letterSpacing,
  }) : this._(
          fontSize: fontSize,
          lineHeight: lineHeight,
          letterSpacing: letterSpacing,
          fontWeight: FontWeight.w500,
        );

  const BaseTextStyle.semibold({
    required double fontSize,
    required double lineHeight,
    double? letterSpacing,
  }) : this._(
          fontSize: fontSize,
          lineHeight: lineHeight,
          letterSpacing: letterSpacing,
          fontWeight: FontWeight.w600,
        );

  const BaseTextStyle.bold({
    required double fontSize,
    required double lineHeight,
    double? letterSpacing,
  }) : this._(
          fontSize: fontSize,
          lineHeight: lineHeight,
          letterSpacing: letterSpacing,
          fontWeight: FontWeight.w700,
        );

  const BaseTextStyle.black({
    required double fontSize,
    required double lineHeight,
    double? letterSpacing,
  }) : this._(
          fontSize: fontSize,
          lineHeight: lineHeight,
          letterSpacing: letterSpacing,
          fontWeight: FontWeight.w900,
        );
}
