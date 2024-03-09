import 'package:flutter/widgets.dart';
import 'package:miro/src/theme/theme.dart';

class MiroApp extends InheritedWidget {
  final MiroTheme theme;
  final MiroTheme darkTheme;
  final Widget home;

  const MiroApp({
    super.key,
    required this.theme,
    required this.darkTheme,
    required this.home,
    this.child = const SizedBox.shrink(),
  }) : super(child: home);

  final Widget child;

  static MiroApp? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MiroApp>();
  }

  @override
  bool updateShouldNotify(MiroApp oldWidget) {
    return true;
  }
}
