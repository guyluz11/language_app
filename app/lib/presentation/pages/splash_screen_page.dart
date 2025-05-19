import 'package:flutter/material.dart';
import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/domain/controllers/tts_controller.dart';
import 'package:word_link/domain/objects/answers_related/answers_collections_object.dart';
import 'package:word_link/domain/objects/cards_related/collections_object.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/core/theme_data.dart';
import 'package:word_link/presentation/pages/pages.dart';

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
    RandomIdController.instance.init();
    NotificationsController.instance.init();
    final int loginCounter =
        PreferencesController.instance.getInt(PreferenceKeys.loginCounter) ?? 0;
    PreferencesController.instance
        .setInt(PreferenceKeys.loginCounter, loginCounter + 1);
    CollectionsObject.init();
    AnswersCollectionsObject.init();
    TtsController.instance.init();
    _navigate();
  }

  Future _navigate() async {
    Navigator.of(context).pop();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: AppThemeData.logoBackgroundColor,
        child: const Center(
          child: ImageAtom(
            'assets/logo.png',
            hero: 'full_logo',
          ),
        ),
      ),
    );
  }
}
