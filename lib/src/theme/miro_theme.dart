import 'package:flutter/widgets.dart';
import 'package:miro/miro.dart';

class MiroTheme extends InheritedWidget {
  final MiroThemeData data;

  const MiroTheme({
    super.key,
    required this.data,
    required super.child,
  });

  static MiroThemeData of(BuildContext context) {
    final miroTheme = context.dependOnInheritedWidgetOfExactType<MiroTheme>();

    if (miroTheme == null) {
      throw Exception('No MiroTheme found in context');
    }

    return miroTheme.data;
  }

  @override
  bool updateShouldNotify(MiroTheme oldWidget) {
    return true;
  }
}
