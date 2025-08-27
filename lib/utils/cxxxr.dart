import 'package:flutter/material.dart';
import 'package:get/get.dart';

class C {
  /// Title / body text / IconButton foreground / common foreground / primary button background
  static C get black => getThemedColor(Color(0xFF0D0D0D), Color(0xFFFFFFFF));

  /// Secondary button foreground / ListTile icon color
  static C get g5 => getThemedColor(Color(0xFF5D5D5D), Color(0xFFC4C4C4));

  /// Border button foreground
  static C get g4 => getThemedColor(Color(0xFF707070), Color(0xFF8F8F8F));

  /// Input placeholder text color
  static C get g3 => getThemedColor(Color(0xFF919191), Color(0xFFAFAFAF));

  /// Border / border button border color
  static C get g2 => getThemedColor(Color(0xFFE6E6E6), Color(0xFF333333));

  /// Secondary button background / input background / general background
  static C get g1 => getThemedColor(Color(0xFFF3F3F3), Color(0xFF414141));

  /// Primary button foreground color
  static C get white => getThemedColor(Color(0xFFFFFFFF), Color(0xFF0D0D0D));

  /// Warning / danger color
  static C get error => getThemedColor(Color(0xFFF40117), Color(0xFFFF7C7E));

  static C getThemedColor(Color lightColor, Color darkColor) {
    return C(l: lightColor, d: darkColor);
  }

  C({required this.d, required this.l});
  final Color d; // raw dark color
  final Color l; // raw light color
  Color get r => Get.context!.isDarkMode ? d : l;
}
