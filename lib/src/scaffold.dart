import 'package:flutter/widgets.dart';
import 'package:miro/src/theme/miro_theme.dart';

class MiroScaffold extends StatefulWidget {
  final Widget body;

  final Widget? floatingActionButton;
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
