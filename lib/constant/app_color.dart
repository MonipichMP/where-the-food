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
  static const Color redColor = Color(0xFFFF5D5D);
}
