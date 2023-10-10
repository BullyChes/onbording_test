import 'package:flutter/material.dart';
import 'package:flutter_onboarding/UI/Style/base_colors.dart';

class Indicator extends StatelessWidget {
  final double? value;

  const Indicator({
    this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      backgroundColor: BaseColors.indicator20,
      color: BaseColors.indicator100,
      minHeight: 3.0,
    );
  }
}
