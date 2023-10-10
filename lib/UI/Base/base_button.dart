import 'package:flutter/material.dart';
import 'package:flutter_onboarding/UI/Style/base_colors.dart';
import 'package:flutter_svg/svg.dart';

class BaseButton extends StatelessWidget {
  final String asset;
  final VoidCallback? onPressed;

  const BaseButton({
    required this.asset,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          fixedSize: const MaterialStatePropertyAll(Size.fromHeight(54)),
          backgroundColor: MaterialStateProperty.all<Color>(BaseColors.white),
          splashFactory: NoSplash.splashFactory,
          shape: const MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          ),
          // overlayColor: MaterialStatePropertyAll(type.pressedColor),
          elevation: const MaterialStatePropertyAll(0),
        ),
        child: SvgPicture.asset(asset),
      ),
    );
  }
}
