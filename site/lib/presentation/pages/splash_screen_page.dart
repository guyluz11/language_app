import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:site/domain/controllers/controllers.dart';
import 'package:site/presentation/atoms/atoms.dart';
import 'package:site/presentation/core/page_routes.dart';
import 'package:site/presentation/core/theme_data.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future initializeApp() async {
    await PreferencesController.instance.init();
    PlayerController.instance.init();
    await VibrationController.instance.init();
    NotificationsController.instance.init();
    final int loginCounter =
        PreferencesController.instance.getInt(PreferenceKeys.loginCounter) ?? 0;
    PreferencesController.instance
        .setInt(PreferenceKeys.loginCounter, loginCounter + 1);

    _navigate();
  }

  Future _navigate() async {
    // TODO: Choose your home page
    // Navigator.of(context).pop();
    //
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => HomePage(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: AppThemeData.logoBackgroundColor,
        child: Center(
          child:
           Column(
             children: [
               Expanded(
                 child: const ImageAtom(
                  'assets/logo.png',
                  hero: 'full_logo',
                           ),
               ),
          const SeparatorAtom(),
          ElevatedButton(
            onPressed: () => context.go(Pages.privacy.name),
            child: const Text('To Privacy Policy Page'),
          ),
               const SeparatorAtom(),

             ],
           ),
        ),
      ),
    );
  }
}
