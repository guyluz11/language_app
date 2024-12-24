import 'package:flutter/material.dart';
import 'package:word_link/presentation/core/color_schemes.dart';
import 'package:word_link/presentation/core/global_variables.dart';
import 'package:word_link/presentation/pages/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      home: SplashPage(),
    );
  }
}
