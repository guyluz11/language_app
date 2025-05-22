import 'package:flutter/material.dart';
import 'package:word_link/presentation/core/color_schemes.dart';
import 'package:word_link/presentation/core/global_variables.dart';
import 'package:word_link/presentation/pages/pages.dart';

Future<void> main({bool debugBanner = true}) async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(debugBanner: debugBanner));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.debugBanner = true});

  final bool debugBanner;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = createTextTheme(context, 'Arya', 'Arya');

    final MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      theme: theme.light(),
      darkTheme: theme.dark(),
      debugShowCheckedModeBanner: debugBanner,
      title: GlobalVariables.appName,
      home: SplashPage(),
    );
  }
}
