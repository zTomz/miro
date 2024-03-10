import 'package:flutter/widgets.dart';
import 'package:miro/src/colors.dart';

class MiroThemeData {
  Color primary;
  Color surface;
  Color background;
  TextDirection textDirection;

  MiroThemeData({
    required this.primary,
    required this.surface,
    required this.background,
    this.textDirection = TextDirection.ltr,
  });

  MiroThemeData.fallback()
      : this(
          primary: Colors.blue,
          surface: Colors.lightenColor(Colors.blue),
          background: Colors.white,
          textDirection: TextDirection.ltr,
        );

  MiroThemeData.fromSeed(
    Color seedColor, {
    Color? surface,
    Color background = Colors.white,
    TextDirection textDirection = TextDirection.ltr,
  }) : this(
          primary: seedColor,
          surface: surface ?? Colors.lightenColor(seedColor, amount: 0.2),
          background: background,
          textDirection: textDirection,
        );
}
