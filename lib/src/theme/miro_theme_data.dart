import 'package:flutter/widgets.dart';
import 'package:miro/src/colors.dart';

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
          primaryColor: Colors.blue,
          surfaceColor: Colors.lightenColor(Colors.blue),
          textDirection: TextDirection.ltr,
        );

  MiroThemeData.fromSeed(Color seedColor,
      {TextDirection textDirection = TextDirection.ltr})
      : this(
          primaryColor: seedColor,
          surfaceColor: Colors.lightenColor(seedColor, amount: 0.2),
          textDirection: textDirection,
        );
}
