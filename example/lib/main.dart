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
      home: const CounterApp(),
    );
  }
}

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MiroScaffold(
      floatingActionButton: MiroButton(
        hoverColor: Colors.black.withOpacity(0.1),
        tapColor: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          setState(() {
            count++;
          });
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: MiroTheme.of(context).primary,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Button clicked: $count times",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
