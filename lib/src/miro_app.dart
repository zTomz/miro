import 'package:miro/miro.dart';
import 'package:flutter/widgets.dart';

class MiroApp extends StatelessWidget {
  final MiroThemeData theme;
  final Widget home;

  const MiroApp({
    super.key,
    required this.theme,
    required this.home,
  });

  @override
  Widget build(BuildContext context) {
    return MiroTheme(
      data: theme,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: home,
      ),
    );
  }
}
