import 'package:flutter/widgets.dart';
import 'package:miro/miro.dart';

/// The root widget of your app. It must contain all the routes
/// and a [MiroTheme] widget. The [MiroApp] widget is the
/// equivalent of the [MaterialApp] widget from Flutter's
/// Material library.
///
/// The [MiroApp] widget is a stateless widget. When creating
/// a new miro app, you must provide a [MiroThemeData] object
/// using the [theme] parameter. This theme will be the default
/// theme for all miro widgets in the app.
///
/// You must also provide a [home] parameter. This is the first
/// screen that the user will see when they open the app.
///
/// The [MiroApp] widget is responsible for setting the
/// [TextDirection] to [TextDirection.ltr] because the miro
/// library does not currently support RTL layout.
class MiroApp extends StatelessWidget {
  /// The theme of the app. This theme will be applied to all
  /// miro widgets in the app.
  final MiroThemeData theme;

  /// The first screen that the user will see when they open
  /// the app.
  final Widget home;

  /// Creates a miro app.
  ///
  /// The [theme] and [home] parameters must not be null.
  const MiroApp({
    super.key,
    required this.theme,
    required this.home,
  });

  @override
  Widget build(BuildContext context) {
    return MiroTheme(
      data: theme,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.black,
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Overlay(
            clipBehavior: Clip.none,
            initialEntries: [
              OverlayEntry(
                builder: (context) => home,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
