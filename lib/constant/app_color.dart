import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class AppColor {
  static const Color primary = Color(0xFF12947c);
  static const Color accent = Color(0xFFAD5389);
  static final MaterialColor primaryMaterial = SuraColor.toMaterial(primary.value);
  static final MaterialColor accentMaterial = SuraColor.toMaterial(accent.value);
  static final MaterialColor whiteMaterial = SuraColor.toMaterial(Colors.white.value);
  static final MaterialColor blackMaterial = SuraColor.toMaterial(Colors.black.value);

  //
  static const Color primaryGradient1 = Color(0xFF2C5364);
  static const Color primaryGradient2 = Color(0xFF3C1053);
  static final List<Color> gradientColors = <Color>[
    primary,
    accent,
  ];

  //material
  static final MaterialColor materialPrimary = SuraColor.toMaterial(primary.value);
  static final MaterialColor materialAccent = SuraColor.toMaterial(accent.value);

  static const Color hintColor = Color(0xFFBEBEBE);
  static const Color titleTextColor = Color(0xFF7E7E7E);
  static const Color subtitleTextColor = Color(0xFF7C7C7C);
  static final Color unSelectTab = Colors.white.withOpacity(0.61);
  static const Color starColor = Color(0xFFE2A621);
  static const Color fbIconColor = Color(0xFF2F5DB3);
  static const Color twitterIconColor = Color(0xFF1DA1F2);
  static const Color igIconColor = Color(0xFFB0398B);
  static const Color backgroundColor = Color(0xFFF8F8F8);
  static const Color backgroundLoginColor = Color(0xFFF4F4F7);
  static const Color menuColor = Color(0xFF757B97);
  static const Color bottomNavColor = Color(0xFFC8C9CB);
  static const Color redColor = Color(0xFFFF5D5D);
  static const Color progressColor = Color(0xFFFF9D55);
  static const Color progressBGColor = Color(0xFFFFF2F2);
  static const Color onlineColor = Color(0xFF129412);
  static const Color onlineTextColor = Color(0xFF46B17B);
  static const Color publishedColor = Color(0xFF28a745);
  static const Color otherChatColor = Color(0xFFF5F6FA);
  static const Color blackCardColor = Color(0xFF2D2F2F);
  static const Color chatProfColor = Color(0xFF49B6C9);
  static final Color white70Color = Colors.white.withOpacity(0.7);
  static const Color likeColor = Color(0xFFffc107);
}
