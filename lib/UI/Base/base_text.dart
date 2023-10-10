import 'package:flutter/material.dart';
import 'package:flutter_onboarding/UI/Style/text_styles.dart';

enum BaseTextStyle {
  regular,
  headline,
}

class BaseText extends StatelessWidget {
  final String text;
  final BaseTextStyle baseTextStyle;

  const BaseText({
    required this.text,
    this.baseTextStyle = BaseTextStyle.regular,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (baseTextStyle) {
      case BaseTextStyle.regular:
        return Text(text, style: TextStyles.bodyText);
      case BaseTextStyle.headline:
        return Text(text, style: TextStyles.headline);
    }
  }
}
