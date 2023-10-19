import 'package:flutter/material.dart';
import '../core_utils/app_dimens.dart';
import '../core_utils/app_style.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final double fontSize;
  final VoidCallback? onPressedFunction;
  const RoundButton(
      {Key? key,
      required this.color,
      required this.textColor,
      required this.text,
      this.fontSize = 16,
      required this.onPressedFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: AppDimens.height50,
      decoration: BoxDecoration(
          // gradient: const LinearGradient(colors: [
          //   Color(0XFFFF228C),
          //   Color(0XFFFCAC76),
          // ]),
          color: color,
          borderRadius: BorderRadius.circular(AppDimens.radius10),
          border: Border.all(color: textColor)),
      child: MaterialButton(
        onPressed: onPressedFunction,
        child: Text(
          text,
          style: AppStyle.buttonTextTextTextStyle
              .copyWith(fontSize: fontSize, color: textColor),
        ),
      ),
    );
  }
}
