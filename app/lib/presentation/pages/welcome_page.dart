import 'package:flutter/material.dart';
import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/core/global_variables.dart';
import 'package:word_link/presentation/molecules/molecules.dart';
import 'package:word_link/presentation/pages/pages.dart';

class WelcomePage extends StatefulWidget {
  static Duration startRenderNextButton = const Duration(seconds: 2);
  static Duration nextButtonDurationTillVisible = const Duration(seconds: 2);
  static Duration showSubTitleDuration = const Duration(seconds: 1);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool showSubTitle = false;
  double buttonOpacity = 0;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future initialize() async {
    await Future.delayed(WelcomePage.showSubTitleDuration);
    if (!mounted) {
      return;
    }
    setState(() {
      showSubTitle = true;
    });
  }

  Future animatedTextFinish() async {
    await Future.delayed(WelcomePage.nextButtonDurationTillVisible);
    setState(() {
      buttonOpacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size * 0.8;

    return PageEnclosureMolecule(
      title: ' ',
      child: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Column(
          children: [
            TextAtom(
              GlobalVariables.appName,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SeparatorAtom(variant: SeparatorVariant.relatedElements),
            if (showSubTitle)
              AnimatedTextAtom(
                text: 'Learn A New Language',
                variant: AnimatedTextVariant.typewriter,
                onDone: animatedTextFinish,
              )
            else
              const TextAtom('', variant: TextVariant.title),
            const SeparatorAtom(),
            const MarginedExpandedAtom(
              child: ImageAtom(
                'assets/logo.png',
                hero: 'full_logo',
              ),
            ),
            const SeparatorAtom(),
          ],
        ),
      ),
    );
  }

  Future<void> onNext() async {
    PreferencesController.instance
        .setBool(PreferenceKeys.finishedIntroduction, value: true);

    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }
}
