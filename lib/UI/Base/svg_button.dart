import 'package:flutter/material.dart';
import 'package:flutter_onboarding/UI/Style/base_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgButton extends StatelessWidget {
  final String asset;
  final VoidCallback? onTap;
  final double width;
  final double height;

  final Color? color;

  const SvgButton({
    required this.asset,
    required this.onTap,
    super.key,
    this.width = 44,
    this.height = 44,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
        splashColor: BaseColors.transparent,
        highlightColor: BaseColors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        onTap: onTap,
        child: Center(
          child: SvgPicture.asset(
            asset,
            theme: SvgTheme(currentColor: color ?? BaseColors.white),
          ),
        ),
      ),
    );
  }
}
