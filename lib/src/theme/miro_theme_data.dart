import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class MiroThemeData {
  Color primaryColor;
  Color surfaceColor;
  TextDirection textDirection;

  MiroThemeData({
    required this.primaryColor,
    required this.surfaceColor,
    this.textDirection = TextDirection.ltr,
  });

  MiroThemeData.fallback()
      : this(
          primaryColor: const Color(0xFF2274A5),
          surfaceColor: lightenColor(const Color(0xFF2274A5)),
          textDirection: TextDirection.ltr,
        );

  MiroThemeData.fromSeed(Color seedColor,
      {TextDirection textDirection = TextDirection.ltr})
      : this(
          primaryColor: seedColor,
          surfaceColor: MiroThemeData.lightenColor(seedColor, amount: 0.2),
          textDirection: textDirection,
        );

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
}
