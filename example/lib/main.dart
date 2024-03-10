import 'package:flutter/widgets.dart';
import 'package:miro/miro.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MiroApp(
      theme: MiroThemeData.fromSeed(const Color(0xFFE6AF2E)),
      home: const MyHomeWidget(),
    );
  }
}

class MyHomeWidget extends StatelessWidget {
  const MyHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(64),
          color: MiroTheme.of(context).surfaceColor,
          child: Text(
            "Hello World",
            style: TextStyle(
              color: MiroTheme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
