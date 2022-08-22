import 'package:flutter/material.dart';
import 'package:where_the_food/constant/app_color.dart';

//custom textStyle
const TextStyle kHeaderStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

const TextStyle kSubHeaderStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

const TextStyle kTitleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

const TextStyle kSubtitleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

const TextStyle kChatStyle = TextStyle(fontSize: 13);

const TextStyle kNormalStyle = TextStyle(fontSize: 12);

extension StyleExtension on TextStyle {
  TextStyle get primary => this.apply(color: AppColor.primaryMaterial);
  TextStyle get accent => this.apply(color: AppColor.accentMaterial);
  TextStyle get white => this.apply(color: Colors.white);
}
