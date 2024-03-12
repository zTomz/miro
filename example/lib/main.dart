import 'package:miro/miro.dart';
import 'package:flutter/widgets.dart';

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
        tooltip: "This is my floating button",
        hoverColor: Colors.black.withOpacity(0.1),
        tapColor: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Button clicked: $count times",
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            MiroButton(
              tooltip:
                  "Floating action button Floating action button Floating action button",
              tooltipDecoration:
                  TooltipDecoration.styleFrom(textAlign: TextAlign.center, maxWidth: 500),
              hoverColor: Colors.black.withOpacity(0.1),
              tapColor: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
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
          ],
        ),
      ),
    );
  }
}
