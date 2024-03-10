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
    return MiroScaffold(
      floatingActionButton: Container(
        width: 50,
        height: 50,
        color: Colors.red,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(64),
          width: MediaQuery.of(context).size.width / 2,
          color: MiroTheme.of(context).surface,
          child: Text(
            "Hello World",
            style: TextStyle(
              color: MiroTheme.of(context).primary,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
