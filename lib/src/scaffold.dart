import 'package:flutter/widgets.dart';
import 'package:miro/src/theme/miro_theme.dart';

/// A scaffold to be used in miro apps.
///
/// The scaffold provides a default layout for a typical miro app.
/// It includes a [body] which is the main content of the screen
/// and an optional [floatingActionButton] which is a button that
/// floats above the [body] and is usually used for performing
/// some action.
///
/// You can also provide a custom [backgroundColor] for the scaffold.
/// If not provided, the background color of the scaffold will be
/// based on the current theme.
class MiroScaffold extends StatefulWidget {
  /// The main content of the scaffold.
  ///
  /// This is usually a [Column] or [ListView] that contains
  /// all the widgets to display on the screen.
  final Widget body;

  /// A button that floats above the [body].
  ///
  /// This is usually used for performing some action.
  final Widget? floatingActionButton;

  /// The background color of the scaffold.
  ///
  /// If not provided, the background color of the scaffold will be
  /// based on the current theme.
  final Color? backgroundColor;

  const MiroScaffold({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.backgroundColor,
  });

  @override
  State<MiroScaffold> createState() => _MiroScaffoldState();
}

class _MiroScaffoldState extends State<MiroScaffold> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: widget.backgroundColor ?? MiroTheme.of(context).background,
      child: Stack(
        children: [
          // Body
          Positioned.fill(
            child: widget.body,
          ),

          // Floating Action Button
          if (widget.floatingActionButton != null)
            Positioned(
              bottom: 24,
              right: 24,
              child: widget.floatingActionButton!,
            ),
        ],
      ),
    );
  }
}

