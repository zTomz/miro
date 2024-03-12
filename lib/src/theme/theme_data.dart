import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:miro/src/colors.dart';

/// Represents a miro theme's data.
///
/// A theme data can be used to configure the visual appearance of
/// miro widgets.
class MiroThemeData {
  /// The primary color of the theme.
  ///
  /// This color is used to tint the app bar and TabBar.
  final Color primary;

  /// The surface color of the theme.
  ///
  /// This color is used to tint the backgrounds of various widgets
  /// such as the Card and the InputDecorator.
  final Color surface;

  /// The background color of the theme.
  ///
  /// This color is used to fill the background of various widgets
  /// such as the Scaffold and the Dialog.
  final Color background;

  /// The direction of the text in this theme.
  ///
  /// This value is used by various widgets to determine the direction of
  /// text in the user interface.
  final TextDirection textDirection;

  /// Creates a theme data with the given colors, text direction, and shape.
  const MiroThemeData({
    required this.primary,
    required this.surface,
    required this.background,
    this.textDirection = TextDirection.ltr,
  });

  /// Creates a fallback theme data with the default colors.
  ///
  /// This theme data uses the Material Design default colors and the text
  /// direction is [TextDirection.ltr].
  MiroThemeData.fallback()
      : this(
          primary: Colors.blue,
          surface: Colors.lightenColor(Colors.blue),
          background: Colors.white,
          textDirection: TextDirection.ltr,
        );

  /// Creates a theme data based on the given seed color.
  ///
  /// The seed color is used to create the primary color of the theme.
  /// The surface and background colors are derived from the
  /// seed color.
  ///
  /// The [surface] and [background] colors can be overridden with the
  /// optional parameters. If they are not provided, they default
  /// to a lightened version of the seed color.
  ///
  /// The [textDirection] defaults to [TextDirection.ltr].
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

  /// Whether the current platform is a touch device.
  ///
  /// This value is true if the current platform is Android, iOS, or Fuchsia.
  bool get isTouchDevice {
    return Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;
  }
}
