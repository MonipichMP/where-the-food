import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/constant/app_color.dart';

//custom textStyle
const TextStyle kHeaderStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

const TextStyle kSubHeaderStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

const TextStyle kTitleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

const TextStyle kSubtitleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

const TextStyle kChatStyle = TextStyle(fontSize: 13);

const TextStyle kNormalStyle = TextStyle(fontSize: 12);

const TextStyle kUpperCaptionStyle = TextStyle(fontSize: 11);

const TextStyle kCaptionStyle = TextStyle(fontSize: 10);

const TextStyle kHintStyle = TextStyle(fontSize: 12, color: AppColor.hintColor);

const TextStyle kPrimaryStyle = TextStyle(fontSize: 12, color: AppColor.primary);

extension StyleExtension on TextStyle {
  TextStyle get primary => this.apply(color: AppColor.primaryMaterial);
  TextStyle get accent => this.apply(color: AppColor.accentMaterial);
  TextStyle get white => this.apply(color: Colors.white);
  TextStyle get white70 => this.apply(color: Colors.white.withOpacity(0.7));
  TextStyle get grey => this.apply(color: Colors.grey);
  TextStyle get black => this.apply(color: Colors.black);
  TextStyle get red => this.apply(color: Colors.red);
  TextStyle get green => this.apply(color: Colors.green);
  TextStyle get hint => this.apply(color: AppColor.hintColor);
  TextStyle get black54 => this.apply(color: Colors.black54);
  TextStyle get menuColor => this.apply(color: AppColor.menuColor);
  TextStyle get onlineColor => this.apply(color: AppColor.onlineTextColor);
}

//custom Shadow

//decoration

final loginContainerDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: AppColor.gradientColors,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
);

final gradientContainerDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: AppColor.gradientColors,
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
);

final cardContainerDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.3),
      offset: Offset(0.0, 4.0),
      spreadRadius: 2.0,
      blurRadius: 4.0,
    ),
  ],
  borderRadius: SuraDecoration.radius(14),
  color: Colors.white,
);
