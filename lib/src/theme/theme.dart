import 'package:flutter/widgets.dart';

import 'package:miro/miro.dart';

/// A widget that sets the theme of miro widgets within its subtree.
///
/// The [MiroTheme] widget is used to set the theme of miro widgets
/// within its subtree. The theme is propagated down to all children
/// of the [MiroTheme] widget.
///
/// By default, the theme is grey. If you want to use a different
/// theme, you can use the [MiroThemeData] class to create a new
/// theme object and pass it to the [MiroTheme] widget.
///
/// The [MiroTheme] widget is useful if you want to have multiple
/// themes in your app. You can wrap each theme's widgets with the
/// [MiroTheme] widget.
///
/// To retrieve the current theme in the widget tree, you can use
/// the [MiroTheme.of] function. This function returns the
/// [MiroThemeData] object of the nearest [MiroTheme] ancestor
/// widget.
class MiroTheme extends InheritedWidget {
  /// The theme data of the widget.
  final MiroThemeData data;

  /// Creates a [MiroTheme] widget with the given [data].
  ///
  /// The [child] argument must not be null.
  const MiroTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Returns the [MiroThemeData] object of the nearest [MiroTheme]
  /// ancestor widget.
  ///
  /// The [BuildContext] must have a [MiroTheme] ancestor widget.
  static MiroThemeData of(BuildContext context) {
    final miroTheme = context
        .dependOnInheritedWidgetOfExactType<MiroTheme>();

    if (miroTheme == null) {
      throw Exception('No MiroTheme found in context');
    }

    return miroTheme.data;
  }

  @override
  bool updateShouldNotify(MiroTheme oldWidget) {
    return oldWidget.data != data;
  }
}
