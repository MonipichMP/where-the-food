import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/constant/app_color.dart';

class PrimaryButton extends StatelessWidget {
  final FutureOr<void> onPressed;
  final Widget child;
  final Widget? icon;
  final Widget? endIcon;
  final bool fullWidth;
  final EdgeInsets? margin;
  final Color? color;
  final Color? textColor;
  final double? roundRect;
  final double? elevation;
  final EdgeInsets? padding;

  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.fullWidth = true,
    this.icon,
    this.endIcon,
    this.margin,
    this.color = AppColor.primary,
    this.textColor,
    this.roundRect = 8,
    this.padding,
    this.elevation = 1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SuraAsyncButton(
      child: child,
      elevation: elevation,
      startIcon: icon,
      endIcon: endIcon,
      fullWidth: fullWidth,
      margin: margin ?? EdgeInsets.zero,
      onPressed: onPressed as FutureOr<void> Function()?,
      textColor: textColor ?? Colors.white,
      color: color,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      shape: SuraDecoration.roundRect(roundRect!),
    );
  }
}
