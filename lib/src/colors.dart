import 'dart:math' as math;

import 'package:flutter/widgets.dart';

abstract final class Colors {
  static Color lightenColor(Color inputColor, {double amount = 0.15}) {
    // Convert input Color to HSL format
    final hslColor = HSLColor.fromColor(inputColor);

    // Adjust lightness by a percentage (clamp to valid range)
    final newLightness =
        math.max(0.0, math.min(1.0, hslColor.lightness + amount));

    // Convert the adjusted HSL values back to a Color object
    return HSLColor.fromAHSL(
            hslColor.alpha, hslColor.hue, hslColor.saturation, newLightness)
        .toColor();
  }

  static const Color black = Color(0xFF000000);

  static const Color white = Color(0xFFFFFFFF);

  static const Color blue = Color(0xFF349AD5);

  static const Color yellow = Color(0xFFEAB948);

  static const Color pink = Color(0xFFE36397);

  static const Color green = Color(0xFF5FAB70);

  static const Color red = Color(0xFFD8464B);

  static const Color transparent = Color(0x00000000);
}
