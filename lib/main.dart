import 'package:flutter/material.dart';
import 'package:flutter_app_template_atoms/domain/controllers/controllers.dart';
import 'package:flutter_app_template_atoms/presentation/core/color_schemes.dart';
import 'package:flutter_app_template_atoms/presentation/core/global_variables.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesController.instance.init();
  PlayerController.instance.init();
  await VibrationController.instance.init();
  NotificationsController.instance.init();
  final int loginCounter =
      PreferencesController.instance.getInt(PreferenceKeys.loginCounter) ?? 0;
  PreferencesController.instance
      .setInt(PreferenceKeys.loginCounter, loginCounter + 1);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = createTextTheme(context, "Arya", "Arya");

    final MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      theme: theme.light(),
      darkTheme: theme.dark(),
      title: GlobalVariables.appName,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
