import 'package:flutter/material.dart';
import 'package:site/domain/controllers/controllers.dart';
import 'package:site/presentation/core/color_schemes.dart';
import 'package:site/presentation/core/global_variables.dart';
import 'package:site/presentation/core/page_routes.dart';

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
    final TextTheme textTheme = createTextTheme(context, 'Arya', 'Arya');

    final MaterialTheme theme = MaterialTheme(textTheme);
    return  MaterialApp.router(
        routerConfig: router,
      theme: theme.light(),
      darkTheme: theme.dark(),
      title: GlobalVariables.appName,
    );
  }
}
