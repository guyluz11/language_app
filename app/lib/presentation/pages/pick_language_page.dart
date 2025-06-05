import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/molecules/molecules.dart';
import 'package:word_link/presentation/organisms/organisms.dart';

class PickLanguagePage extends StatefulWidget {
  const PickLanguagePage({super.key});

  @override
  State<PickLanguagePage> createState() => _PickLanguagePageState();
}

class _PickLanguagePageState extends State<PickLanguagePage> {
  LanguageEnum? selectedLanguage;

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    final savedLanguage = PreferencesController.instance
        .getString(PreferenceKeys.learningLanguage);
    if (savedLanguage != null) {
      setState(() {
        selectedLanguage = LanguageEnum.fromString(savedLanguage);
      });
    }
  }

  Future<void> _onLanguageSelected(LanguageEnum language) async {
    await PreferencesController.instance.setString(
      PreferenceKeys.learningLanguage,
      language.name,
    );

    if (!mounted) return;

    // Find the IntroductionScreenState in the widget tree
    final IntroductionScreenState? introState =
        context.findAncestorStateOfType<IntroductionScreenState>();
    if (introState != null) {
      introState.next();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const availableLanguages = LanguageEnum.values;

    return PageEnclosureMolecule(
      title: 'Choose a Language',
      subTitle: 'Select the language you want to learn',
      child: SizedBox(
        height: size.height * 0.8,
        width: size.width * 0.9,
        child: GridAtom(
          itemCount: availableLanguages.length,
          itemBuilder: (context, index) {
            final language = availableLanguages[index];
            return SelectLanguageCardOrganism(
              language: language,
              isSelected: language == selectedLanguage,
              onTap: () => _onLanguageSelected(language),
            );
          },
        ),
      ),
    );
  }
}
